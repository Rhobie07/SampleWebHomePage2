# Marci Metzger Homes

A single-page Flutter web redesign of [marcimetzger.com](https://marcimetzger.com/), based on the approved **B — Cinematic destination** visual direction.

## SDK compatibility

Verified with **Flutter 3.44.7 / Dart 3.12.2**. The project supports Dart `>=3.12.2 <4.0.0`; upgrading to Dart 3.13 is not required. The committed lockfile was resolved with Dart 3.12.2.

## Run

```sh
flutter pub get
flutter run -d chrome
```

To open the site manually in a browser, use `flutter run -d web-server --web-hostname 127.0.0.1 --web-port 8080`, then visit `http://127.0.0.1:8080`.

## Production

```sh
flutter build web --release --no-web-resources-cdn
python3 -m http.server 8081 --directory build/web
```

Deploy the contents of `build/web/` to a static host. The build bundles its renderer, fonts, and photography locally. There is no separate web frontend or backend service.

## GitHub Pages

Website: **https://rhobie07.github.io/SampleWebHomePage2/**

The repository uses GitHub Actions as its Pages publishing source. The workflow in `.github/workflows/github-pages.yml` deploys automatically after a push to `main`; it can also be started from **Actions → Deploy Flutter web to GitHub Pages → Run workflow**.

- CI uses the verified Flutter **3.44.7 / Dart 3.12.2** toolchain, resolves the committed lockfile, and runs static analysis before building.
- The build reads the Pages base path and passes it to `flutter build web --base-href`, so scripts, fonts, and images load under `/SampleWebHomePage2/`.
- Only `build/web/` is published. Do not commit generated build output.
- Deployment uses GitHub’s automatic workflow token and scoped Pages permissions. No personal access token or additional repository secrets are required.
- GitHub Pages hosting and GitHub-hosted Actions are free for this public repository.

To publish an update, commit the changes and push to `main`, then check the [deployment workflow](https://github.com/Rhobie07/SampleWebHomePage2/actions/workflows/github-pages.yml).

## Structure

```text
lib/
├── main.dart
├── home/
│   ├── home_page.dart
│   ├── navigation/
│   └── sections/
│       ├── header/
│       ├── hero/
│       ├── highlights/
│       ├── about/
│       ├── results/
│       ├── search/
│       ├── gallery/
│       ├── services/
│       ├── contact/
│       └── footer/
└── shared/
    ├── animation/
    ├── layout/
    ├── navigation/
    ├── privacy/
    ├── theme/
    └── widgets/
```

- `home/home_page.dart` owns page composition, section anchors, and navigation state.
- Each section has an entry Dart library and a local `widgets/` directory. For example, `contact/contact_section.dart` composes `ContactDetails` and `ContactForm`, with `ContactField` shared inside that section.
- Shared layout, colors, typography, buttons, images, and motion have focused libraries under `shared/`. Imports point directly to the needed library; there are no legacy forwarding files or barrel exports.
- Stateful widgets keep their private `State` classes and controller disposal in the same file. Search state belongs to `HomeSearchForm`, contact state to `ContactForm`, and viewer state to the gallery widgets. No application-wide state framework is needed.

- `assets/images/sources.json` records the source URLs for the original 21 homepage images and four social-logo assets. The social logos are transparent PNGs rasterized from the original website’s inline Facebook, Instagram, LinkedIn, and Yelp SVGs; no additional icon package or runtime download is needed. Gallery photographs are not represented as active listings.
- `assets/fonts/` contains locally hosted Cormorant Garamond and Manrope, including their SIL Open Font Licenses.
- `design_preview/` preserves the visual-review concepts; it is not part of the deployed application.
- `screenshots/` contains the implemented mobile, tablet, and desktop captures.

## Interaction contracts

- Navigation scrolls to sections on the same page. The header changes to an opaque light surface after scrolling.
- All seven gallery photographs open in a full-image viewer with next/previous controls, thumbnails, arrow-key navigation, and Escape to close.
- Search retains the original location, type, sort, bedroom, bath, and price controls. It validates price ranges and prepares a criteria summary. **Browse current listings** opens Marci’s published Zillow profile; the form does not imply that its criteria filter Zillow. **Email my wish list** includes every selected criterion in an email draft.
- Contact validates name, email, and message, then opens the user’s email app addressed to `marcimetzger@gmail.com`, as published on the original site’s [contact page](https://marcimetzger.com/lets-move). Nothing is sent until the visitor confirms in their email app. There is no server-side submission or message storage. The email address is also selectable for visitors without a configured mail app.
- Phone, directions, Facebook, Instagram, LinkedIn, and Yelp destinations use the original business information.
- Footer social destinations use branded, icon-only buttons with 48 × 48 touch targets, accessible tooltips, keyboard-focus feedback, and animated hover states. Each profile opens in a new tab.
- The footer legal row contains only copyright and **Privacy & cookies**. The header logo remains available to return to the top.
- No analytics or tracking cookies are loaded. First visits show no automatic privacy notice, and no dismissal preference is stored. The footer’s **Privacy & cookies** link opens the original cookie policy on demand, explicitly distinguished from this redesign’s behavior.
- Hover and focus states use stable dimensions, restrained shadows, and short transitions. System reduced-motion preferences disable movement and use immediate section navigation.
- The sales volume and client counts are explicitly dated **2021**, not presented as current-year results.

## Verification

```sh
flutter analyze
flutter build web --release --no-web-resources-cdn
```

The actual release build was inspected from hero to footer at **375 × 900**, **768 × 1000**, and **1440 × 1000**, with no unintended horizontal overflow or release runtime errors. Browser smoke checks exercised mobile navigation, dropdown menus, invalid price ranges, search summaries, required contact fields, invalid email addresses, email-draft contents, the Zillow destination, gallery controls and keyboard wrapping, button hover geometry, and reduced-motion behavior. No real messages were sent.
