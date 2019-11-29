# Must have `sentry-cli` installed globally
# Following variable must be passed in

SENTRY_AUTH_TOKEN=9933a89e61fa490b80388ba2e23bdb676d57050f413a46d29fab51d5ed5e1e10

SENTRY_ORG=home-g30
SENTRY_PROJECT=javascript
VERSION=`sentry-cli releases propose-version`
PREFIX=js

setup_release: create_release associate_commits upload_sourcemaps

create_release:
	sentry-cli --auth-token $(SENTRY_AUTH_TOKEN) releases -o $(SENTRY_ORG) new -p $(SENTRY_PROJECT) $(VERSION)

associate_commits:
	sentry-cli --auth-token $(SENTRY_AUTH_TOKEN) releases -o $(SENTRY_ORG) -p $(SENTRY_PROJECT) set-commits --auto $(VERSION)

upload_sourcemaps:
	sentry-cli --auth-token $(SENTRY_AUTH_TOKEN) releases -o $(SENTRY_ORG) -p $(SENTRY_PROJECT) files $(VERSION) \
		upload-sourcemaps --url-prefix "~/$(PREFIX)" --rewrite --validate dist/$(PREFIX)