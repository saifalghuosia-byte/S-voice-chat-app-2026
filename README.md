# S Voice Chat — mobile-build starter

This is a Flutter front-end prototype for Android/iOS. It is not yet a production
social audio service.

## Build an APK using only your Android phone

You can use GitHub's cloud build. You will need a free GitHub account and a
mobile browser. No laptop is required for this build route.

1. Download and extract this ZIP on your phone.
2. Open https://github.com in Chrome and create/sign in to your account.
3. Create a new **public** repository named `s-voice-chat` (public is easiest
   for GitHub Actions on a free account; do not upload secrets or private data).
4. Upload the extracted project files and folders to the repository. Make sure
   `pubspec.yaml`, `lib/`, `assets/`, and `.github/workflows/build-apk.yml` are
   at the repository root.
5. Open the repository's **Actions** tab. If GitHub asks, enable Actions.
6. Select **Build S Voice Chat APK**, then tap **Run workflow**.
7. When the run finishes successfully, open that run, scroll to **Artifacts**,
   and download `s-voice-chat-debug-apk`. Extract it and install the APK on
   your Android phone. Android may ask you to allow installation from your browser/files app.

## What this build contains

- Demo phone-number entry screen (no real OTP yet)
- Home page and sample room list
- Interactive local 9-seat board demo
- Wallet, agency and profile placeholder screens
- Your supplied S Voice logo and navy/blue/purple theme

## Important limitations

This is a prototype APK, not a complete live audio app. It does not yet include
real authentication, live audio infrastructure, server-synced seats, secure
identity/age verification, payment processing, coin/gift transactions,
withdrawals, agency commission accounting, admin moderation backend, or
production security. Those require backend setup, service credentials,
testing, and legal/payment-provider checks. Never collect face images or
identity documents in this prototype.

For an iOS build, use a macOS/Xcode build environment.
