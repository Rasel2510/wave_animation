# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## Last Released Date:- 29-January-2026
## [1.0.3] - 2026-01-29

### Added
- Initial release of `wave_animation` package
- `WaveWidget` - Main widget for creating customizable wave animations
- `WavePainter` - Custom painter supporting multiple wave layers with gradient colors
- `WaveMotionPattern` enum with 5 motion patterns:
  - `classic` - Simple horizontal wave motion
  - `flowField` - Dynamic flow-like motion with varying speeds
  - `ribbonDrift` - Smooth drifting motion like ribbons
  - `flowFieldLoop` - Flow field pattern with seamless looping
  - `ribbonLoop` - Ribbon drift pattern with looping animation
- Customizable wave parameters:
  - `height` - Widget height control
  - `gradientColors1` & `gradientColors2` - Dual-layer gradient support
  - `lineCount` - Number of wave lines (default: 3)
  - `amplitude` - Wave height control (default: 20.0)
  - `waveLength` - Distance between wave peaks (default: 200.0)
  - `speed` - Animation speed multiplier (default: 1.0)
  - `visible` - Visibility toggle (default: true)
- Full null safety support
- AnimatedBuilder integration with speed and visibility control
- Unit tests for widget instantiation and painter class
- Example app demonstrating various configurations
- Comprehensive documentation and README

### Planned
- Additional wave motion patterns
- Performance optimizations for complex animations
- More customization options for wave behavior