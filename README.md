# Tip Calculator

A Flutter tip calculator with bill entry, a 0–30% tip slider, people controls, and live per-person totals. Invalid or empty bill input is treated as zero.

## Run

Open [DartPad](https://dartpad.dev/), choose Flutter, paste `lib/main.dart`, and press **Run**. To run locally, install Flutter, run `flutter create --platforms=web .` once, then run `flutter pub get` and `flutter run -d chrome`.

## Checklist

- Typing updates the totals immediately; invalid and empty input safely becomes zero.
- People count stays at or above one and can be increased/decreased.
- Tip, total, and per-person amounts display two decimals.
- Guide case: bill 1000, tip 10%, 4 people gives total 1100.00 and 275.00 per person.
- Run `flutter test`; GitHub Actions analyzes, tests, builds, and publishes the web preview.
