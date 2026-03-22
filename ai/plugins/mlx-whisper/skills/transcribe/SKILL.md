---
name: transcribe
description: Transcribe audio files to text using mlx_whisper on Apple Silicon. Use when the user has an audio file (MP3, WAV, AAC, OGG, etc.) they want transcribed.
---

# Transcribe Audio

Transcribe audio files locally on Apple Silicon using mlx_whisper. Audio never leaves the device.

## 1) Determine the audio file

Identify the audio file path from the user's request. If not provided, ask.

## 2) Run mlx_whisper

```bash
mlx_whisper "<audio_file_path>" --model mlx-community/whisper-large-v3-turbo --output-format txt --output-dir /tmp/
```

- Always quote the file path (filenames often contain spaces)
- Use `whisper-large-v3-turbo` by default for best quality
- If the user asks for faster/lower quality, use `mlx-community/whisper-tiny` instead
- If the user asks for timestamps, use `--output-format json` instead of `txt`
- Models auto-download on first use from HuggingFace

## 3) Read and present the output

The output file will be written to `/tmp/` with the same base name as the input file (e.g., `/tmp/audio.txt`).

Read the output file and present the transcription to the user.

If the transcription ends with repeated lines (a known Whisper hallucination artifact when audio trails off into silence), trim those from the output.

## Prerequisites

mlx_whisper must be installed. If not found, install it with:

```bash
uv tool install mlx-whisper
```
