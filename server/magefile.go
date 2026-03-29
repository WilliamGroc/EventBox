//go:build mage
// +build mage

package main

import (
	"fmt"
	"os"
	"os/exec"

	"github.com/magefile/mage/mg" // mg contains helpful utility functions, like Deps
)

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
	cmd := exec.Command("go", "build", "-o", "/tmp/EventBoxServer", ".")
	cmd.Stdout = os.Stdout
	cmd.Stderr = os.Stderr
	return cmd.Run()
}

// A custom install step if you need your bin someplace other than go/bin
func Install() error {
	mg.Deps(Build)
	fmt.Println("Installing...")
	return os.Rename("/tmp/EventBoxServer", "/usr/bin/EventBoxServer")
}

// Clean up after yourself
func Clean() {
	fmt.Println("Cleaning...")
	os.RemoveAll("/tmp/EventBoxServer")
}

// Air lance le rechargement à chaud avec Air
func Dev() error {
	fmt.Println("Lancement d'Air pour le rechargement à chaud...")

	cmd := exec.Command("air")
	cmd.Stdout = os.Stdout
	cmd.Stderr = os.Stderr

	return cmd.Run()
}
