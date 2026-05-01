# weight_tracker

Weight tracking Flutter app with Supabase authentication and local SQLite storage via Drift.

## Local Setup

1. Install dependencies:
	- `flutter pub get`
2. Create your local env file from the template:
	- Copy `.env.example` to `.env`
3. Fill in required values in `.env`:
	- `SUPABASE_URL`
	- `SUPABASE_ANON_KEY`
	- `GOOGLE_WEB_CLIENT_ID`
4. Run the app:
	- `flutter run`

## Notes

- `.env` is ignored by git.
- `.env.example` is committed as the shared template.
