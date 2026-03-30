//go:build mage
// +build mage

package main

import (
	"fmt"
	"io"
	"os"
	"os/exec"
	"path/filepath"
	"runtime"

	"github.com/magefile/mage/mg" // mg contains helpful utility functions, like Deps
)

func binaryName() string {
	if runtime.GOOS == "windows" {
		return "EventBoxServer.exe"
	}

	return "EventBoxServer"
}

func buildOutputPath() string {
	return filepath.Join(os.TempDir(), binaryName())
}

func installOutputPath() string {
	if runtime.GOOS == "windows" {
		baseDir := os.Getenv("LOCALAPPDATA")
		if baseDir == "" {
			homeDir, err := os.UserHomeDir()
			if err == nil {
				baseDir = filepath.Join(homeDir, "AppData", "Local")
			}
		}
		if baseDir == "" {
			baseDir = os.TempDir()
		}

		return filepath.Join(baseDir, "EventBox", "bin", binaryName())
	}

	return filepath.Join("/usr/bin", binaryName())
}

func installBinary(sourcePath, destinationPath string) error {
	if err := os.MkdirAll(filepath.Dir(destinationPath), 0o755); err != nil {
		return err
	}

	sourceFile, err := os.Open(sourcePath)
	if err != nil {
		return err
	}
	defer sourceFile.Close()

	destinationFile, err := os.Create(destinationPath)
	if err != nil {
		return err
	}

	if _, err := io.Copy(destinationFile, sourceFile); err != nil {
		destinationFile.Close()
		return err
	}

	if err := destinationFile.Close(); err != nil {
		return err
	}

	if runtime.GOOS != "windows" {
		if err := os.Chmod(destinationPath, 0o755); err != nil {
			return err
		}
	}

	return os.Remove(sourcePath)
}

// Manage your deps, or running package managers.
func InstallDeps() error {
	fmt.Println("Installing Deps...")
	cmd := exec.Command("go", "mod", "tidy")
	cmd.Stdout = os.Stdout
	cmd.Stderr = os.Stderr
	return cmd.Run()
}

// A build step that requires additional params, or platform specific steps for example
func Build() error {
	mg.Deps(InstallDeps)
	fmt.Println("Building...")
	cmd := exec.Command("go", "build", "-o", buildOutputPath(), ".")
	cmd.Stdout = os.Stdout
	cmd.Stderr = os.Stderr
	return cmd.Run()
}

// A custom install step if you need your bin someplace other than go/bin
func Install() error {
	mg.Deps(Build)
	fmt.Println("Installing...")
	return installBinary(buildOutputPath(), installOutputPath())
}

// Clean up after yourself
func Clean() {
	fmt.Println("Cleaning...")
	os.RemoveAll(buildOutputPath())
}

// Air lance le rechargement à chaud avec Air
func Dev() error {
	fmt.Println("Lancement d'Air pour le rechargement à chaud...")

	var cmd *exec.Cmd
	if runtime.GOOS == "windows" {
		cmd = exec.Command("air", "-c", ".air.windows.toml")
	} else {
		cmd = exec.Command("air")
	}
	cmd.Stdout = os.Stdout
	cmd.Stderr = os.Stderr

	return cmd.Run()
}
