module github.com/codex-devlab/codex-devlab.github.io

go 1.21

toolchain go1.22.10

// For Future costom update
require github.com/hugo-toha/toha/v4 v4.7.0 // indirect

replace(
    github.com/hugo-toha/toha/v4 => github.com/codex-devlab/customs_theme/v4 v4.7.0
)