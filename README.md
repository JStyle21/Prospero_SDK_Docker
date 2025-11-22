# Prospero SDK Docker

Docker environment for building PS4 and PS5 payloads with both SDKs pre-installed.

## Quick Start

### Build the Docker image

```bash
docker-compose build
```

### Compile a PS5 project (e.g., ftpsrv)

```bash
# From your project directory (e.g., ftpsrv)
cd /path/to/ftpsrv
docker-compose -f /path/to/Prospero_SDK_Docker/docker-compose.yml run --rm ps5-build
```

Or using PROJECT_PATH:

```bash
PROJECT_PATH=/path/to/ftpsrv docker-compose run --rm ps5-build
```

### Compile a PS4 project

```bash
cd /path/to/your-ps4-project
docker-compose -f /path/to/Prospero_SDK_Docker/docker-compose.yml run --rm ps4-build
```

## Services

| Service | Description |
|---------|-------------|
| `ps5-build` | Build with PS5 SDK (runs `make` by default) |
| `ps4-build` | Build with PS4 SDK (runs `make` by default) |
| `ps5-shell` | Interactive shell with PS5 SDK |
| `ps4-shell` | Interactive shell with PS4 SDK |

## Usage Examples

### Run make with PS5 SDK

```bash
docker-compose run --rm ps5-build
```

### Run make clean then make

```bash
docker-compose run --rm ps5-build make clean all
```

### Interactive shell

```bash
docker-compose run --rm ps5-shell
```

### Custom make target

```bash
docker-compose run --rm ps5-build make release
```

### Specify project path

```bash
PROJECT_PATH=/home/user/ftpsrv docker-compose run --rm ps5-build
```

## Environment Variables

- `SDK_TYPE` - Set to `ps4` or `ps5` to select SDK (default: `ps5`)
- `PROJECT_PATH` - Path to your project directory (default: current directory)
- `PS4_PAYLOAD_SDK` - Path to PS4 SDK inside container
- `PS5_PAYLOAD_SDK` - Path to PS5 SDK inside container

## SDK Locations (inside container)

- PS4 SDK: `/opt/ps4-payload-sdk`
- PS5 SDK: `/opt/ps5-payload-sdk`

## Building ftpsrv

```bash
# Clone ftpsrv
git clone https://github.com/ps5-payload-dev/ftpsrv.git
cd ftpsrv

# Build with PS5 SDK
docker-compose -f /path/to/Prospero_SDK_Docker/docker-compose.yml run --rm ps5-build
```

## Troubleshooting

### Permission issues

If you encounter permission issues with output files, you can run:

```bash
docker-compose run --rm --user $(id -u):$(id -g) ps5-build
```

### Missing dependencies

The container includes: clang-18, lld-18, make, git, cmake, meson, pkg-config
