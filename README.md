# EventBox

EventBox contains a Flutter client and a Go server.

## Project Structure

- `lib/`: Flutter application code.
- `server/`: Go API, Mage tasks, and Air live-reload configuration.

## Flutter Development

Install dependencies from the repository root:

```bash
flutter pub get
```

Run code generation in watch mode:

```bash
dart run build_runner watch -d
```

Start the Flutter app as usual:

```bash
flutter run
```

### Config emulator

```bash
sdkmanager "system-images;android-36;google_apis;x86_64"
avdmanager create avd -n "Pixel" -k "system-images;android-36;google_apis;x86_64" -d "pixel_5"
emulator -avd Pixel -c 1024M
```

## Server Development

The Go server lives in `server/` and uses Mage for common tasks.

Install Go dependencies:

```bash
cd server
mage InstallDeps
```

Run the server in development mode with live reload:

```bash
cd server
mage Dev
```

## Windows Notes

On Windows, `mage Dev` uses `server/.air.windows.toml` so Air builds `tmp/main.exe` and runs it with a Windows-compatible command.

On macOS and Linux, `mage Dev` uses `server/.air.toml`.

## Useful Mage Tasks

Build the server binary:

```bash
cd server
mage Build
```

Install the server binary:

```bash
cd server
mage Install
```

Clean build artifacts created by Mage:

```bash
cd server
mage Clean
```