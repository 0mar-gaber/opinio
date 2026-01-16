# Work Sans Font Setup

## Download Work Sans Font

To use the Work Sans font in your app, you need to download the font files:

1. Visit: https://fonts.google.com/specimen/Work+Sans
2. Click "Download family" button
3. Extract the downloaded ZIP file
4. Copy the following font files to this `assets/fonts/` directory:
   - `WorkSans-Regular.ttf`
   - `WorkSans-Medium.ttf`
   - `WorkSans-Bold.ttf`

## Font Files Required

- `WorkSans-Regular.ttf` (weight: 400)
- `WorkSans-Medium.ttf` (weight: 500)
- `WorkSans-Bold.ttf` (weight: 700)

## After Adding Fonts

Run:
```bash
flutter pub get
flutter clean
flutter run
```

The app will automatically use Work Sans once the font files are added.
