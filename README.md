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
    ├── theme/
    └── widgets/
```

- `home/home_page.dart` owns page composition, section anchors, and navigation state.
- Each section has an entry Dart library and a local `widgets/` directory. For example, `contact/contact_section.dart` composes `ContactDetails` and `ContactForm`, with `ContactField` shared inside that section.
- Shared layout, colors, typography, buttons, images, and motion have focused libraries under `shared/`. Imports point directly to the needed library; there are no legacy forwarding files or barrel exports.
- Stateful widgets keep their private `State` classes and controller disposal in the same file. Search state belongs to `HomeSearchForm`, contact state to `ContactForm`, and viewer state to the gallery widgets. No application-wide state framework is needed.

- `assets/images/sources.json` records the source URLs for the original 21 homepage images, four social-logo assets, and the Google Maps logo. Social logos are transparent PNGs rasterized from the original website’s inline SVGs. The Maps logo is Google's locally bundled product-page PNG; no icon package or runtime download is needed. Gallery photographs are not represented as active listings.
- `assets/fonts/` contains locally hosted Cormorant Garamond and Manrope, including their SIL Open Font Licenses.
- `design_preview/` preserves the visual-review concepts; it is not part of the deployed application.
- `screenshots/` contains the implemented mobile, tablet, and desktop captures.

## Interaction contracts

- Navigation scrolls to sections on the same page. The header changes to an opaque light surface after scrolling.
- The gallery is a cyclic carousel with a larger centered photo and smaller neighboring previews. Previous/next buttons sit at the left and right image edges. A centered row has one bar per photo instead of a numeric count: the current bar widens, selection changes animate, and hover/focus add feedback without shifting the touch targets. Clicking a bar selects its photo.
- Autoplay advances one photo every 10 seconds. There are no visible Play/Pause buttons; Space toggles playback while the carousel is focused, and screen readers have pause/resume actions. Ordinary hover and retained control focus do not stop playback. Dragging, full-image viewing, and an inactive app temporarily stop the timer; reduced-motion preferences disable autoplay and make manual navigation immediate.
- All seven gallery photographs still open in the full-image viewer, with next/previous controls, thumbnails, arrow-key navigation, and Escape to close. Opening or closing the viewer does not reset the user's playback choice.
- Carousel layout references: [Swiper's centered slides](https://swiperjs.com/demos/130-centered/core.html) and [Bootstrap's image-edge controls](https://getbootstrap.com/docs/5.3/components/carousel/#basic-examples). The implementation remains native Flutter.
- Search retains the original location, type, sort, bedroom, bath, and price controls. It validates price ranges and prepares a criteria summary. **Browse current listings** opens Marci’s published Zillow profile; the form does not imply that its criteria filter Zillow. **Email my wish list** includes every selected criterion in an email draft.
- Contact validates name, email, and message, then opens the user’s email app addressed to `marcimetzger@gmail.com`, as published on the original site’s [contact page](https://marcimetzger.com/lets-move). Nothing is sent until the visitor confirms in their email app. There is no server-side submission or message storage. The email address is also selectable for visitors without a configured mail app.
- Phone, directions, Facebook, Instagram, LinkedIn, and Yelp destinations use the original business information. **Get directions** displays the multicolor Google Maps logo instead of the generic arrow and opens the same business address in Google Maps.
- Footer social destinations use branded, icon-only buttons with 48 × 48 touch targets, accessible tooltips, keyboard-focus feedback, and animated hover states. Each profile opens in a new tab.
- The footer contains only the four social icons and the copyright beneath them, centered at every breakpoint. Branding, partner badges, footer navigation, and privacy controls are intentionally omitted.
- No analytics or tracking cookies are loaded. There is no privacy popup or locally stored dismissal preference.
- Hover and focus states use stable dimensions, restrained shadows, and short transitions. System reduced-motion preferences disable movement and use immediate section navigation.
- The sales volume and client counts are explicitly dated **2021**, not presented as current-year results.

## Verification

```sh
flutter analyze
flutter build web --release --no-web-resources-cdn
```

The actual release build was inspected from hero to footer at **375 × 900**, **768 × 1000**, and **1440 × 1000**, with no unintended horizontal overflow or release runtime errors. Browser smoke checks exercised mobile navigation, dropdown menus, invalid price ranges, search summaries, required contact fields, invalid email addresses, email-draft contents, the Zillow destination, gallery controls and keyboard wrapping, button hover geometry, and reduced-motion behavior. No real messages were sent.
