# iReport Designer

iReport 2.0.2 running on Java in Docker with optimized display settings for macOS XQuartz.

## Supported versions

* 2.0.2 (current implementation)

## Getting Started

Follow these steps to set up and run iReport 2.0.2:

### Step 1: Install and Configure XQuartz
1. Install XQuartz from https://www.xquartz.org/
2. Open XQuartz and go to **Preferences** → **Security**
3. Enable: "Allow connections from network clients"
4. **Optional but recommended:** Go to **Preferences** → **Output**
   - Uncheck "Enable Retina display support" if available
   - Set "Colors" to 256 or Thousands (instead of Millions)
5. Restart XQuartz after making changes

### Step 2: Build Docker Image
```bash
./build.sh
```

### Step 3: Run iReport
```bash
./run.sh
```

That's it! iReport will open and you can start working with your reports. For best results:
- **Open files from:** Navigate to `/root/reports` directory when opening .jrxml files
- **Compile reports to:** Use `/root/reports` as your compilation target directory

Your reports and compiled files (.jasper) will be accessible in the `reports/` folder in your project directory.

## Manual Run
If you prefer to run manually:

```bash
# Allow X11 forwarding
xhost + 127.0.0.1

# Run the container
docker run \
--rm \
--env DISPLAY=host.docker.internal:0 \
--env QT_X11_NO_MITSHM=1 \
--env NO_AT_BRIDGE=1 \
--env LIBGL_ALWAYS_INDIRECT=1 \
--env JAVA_TOOL_OPTIONS="-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true" \
--hostname ireport \
--volume ${PWD}/reports:/root/reports \
ireport:2.0.2

# Clean up X11 permissions
xhost - 127.0.0.1
```

## Troubleshooting

### ✅ Display Issues Fixed
This Docker image includes comprehensive fixes for common Java Swing display issues on macOS XQuartz:

- **Black screen/components**: Fixed with proper Java rendering settings
- **Flickering (black-white-black)**: Resolved by disabling hardware acceleration
- **Components visible in screenshots but black during use**: Fixed with buffer and refresh optimizations

### Java Display Fixes Included
The image automatically applies these Java system properties:
- Disabled X11 hardware acceleration (`-Dsun.java2d.xrender=false`)
- Metal Look and Feel for consistent appearance
- Optimized buffer management for XQuartz compatibility
- Font rendering improvements

### XQuartz Issues
- Make sure XQuartz is running before starting the container
- Ensure network connections are enabled in XQuartz preferences
- If display still appears black after startup, try resizing the iReport window slightly to force a refresh

### Still Having Issues?
1. Check that XQuartz is properly configured with network client connections enabled
2. Try running `./run.sh` which includes all necessary environment variables
3. If components appear black, minimize and maximize the iReport window to force a refresh
4. Ensure no other X11 applications are interfering with the display

## Features

- Pre-configured with all necessary Java display optimizations for macOS
- Automated X11 setup and cleanup via run script
- Includes all required fonts and GUI libraries
- Reports directory mounted for easy file access
- Optimized for XQuartz compatibility on macOS
