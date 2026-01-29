# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.4] - 2026-01-29

### Fixed
- Fixed deprecated Color properties (`red`, `green`, `blue`) - now using `.r`, `.g`, `.b`
- Resolved all static analysis warnings

### Added
- Comprehensive dartdoc comments for all public APIs
- Detailed documentation for `WavePainter` class and all its properties
- Complete documentation for `WaveMotionPattern` enum
- Documentation for `WaveWidget` parameters

### Changed
- Improved code documentation coverage to meet pub.dev standards (20%+ requirement)

## [1.0.3] - 2026-01-29
### Changed
- Minor updates

## [1.0.2] - 2026-01-21
### Added
- Initial release of `wave_animation` package
- `WaveWidget` - Main widget for creating customizable wave animations
- `WavePainter` - Custom painter supporting multiple wave layers with gradient colors
- `WaveMotionPattern` enum with 5 motion patterns
- Full null safety support
- Example app and comprehensive documentation