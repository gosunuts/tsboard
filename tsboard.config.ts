export const IS_DEV = false // production build by default; switch to true only for vite dev server
export const VITE_PORT = 3000
export const DEV_DOMAIN = "http://localhost"
const dev_url = `${DEV_DOMAIN}:${VITE_PORT}`

const runtime_prod_url = typeof window !== "undefined" ? window.location.origin : ""

// TSBOARD base settings
export const TSBOARD = {
  API: (IS_DEV ? dev_url : runtime_prod_url) + "/goapi",
  API_PORT: 3003,
  MAX_UPLOAD_SIZE: 1024 * 1024 * 100,
  PREFIX: "",
  SITE: {
    HOME: {
      CATEGORIES: [
        { id: "free", limit: 8 },
        { id: "sirini", limit: 8 },
        { id: "photo", limit: 4 },
      ],
      COLUMNS: {
        COLS: 6,
        BOARDS: [
          { id: "free", limit: 10 },
          { id: "sirini", limit: 10 },
        ],
        GALLERY: { id: "photo", limit: 6 },
      },
    },
    MOBILE: { WRITE: "free", PHOTO: "photo" },
    NAME: "TSBOARD",
    OAUTH: {
      GOOGLE: true,
      NAVER: true,
      KAKAO: true,
    },
    URL: IS_DEV ? dev_url : runtime_prod_url,
  },
  VERSION: "v1.0.6",
}

// Default color palette (Vuetify material colors)
export const COLOR = {
  HOME: {
    THEME: "light",
    MAIN: "#424242",
    TOOLBAR: "#424242",
    FOOTER: "#F5F5F5",
    BACKGROUND: "#F5F5F5",
  },
  ADMIN: {
    THEME: "light",
    MAIN: "#795548",
    TOOLBAR: "#EFEBE9",
    FOOTER: "#EFEBE9",
    BACKGROUND: "#EFEBE9",
  },
  BLOG: {
    THEME: "dark",
    MAIN: "#121212",
    TOOLBAR: "#121212",
    FOOTER: "#121212",
    BACKGROUND: "#121212",
  },
  GALLERY: {
    THEME: "light",
    MAIN: "#121212",
    TOOLBAR: "#121212",
    FOOTER: "#121212",
    BACKGROUND: "#121212",
  },
  COMMENT: {
    TOOLBAR: { BLOG: "#1c1c1c", HOME: "#f1f1f1", BOARD_WRITER: "#FFF3E0", BLOG_WRITER: "#121212" },
    NAMETAG: { BLOG: "#9E9E9E", HOME: "#616161", BOARD_WRITER: "#EF6C00", BLOG_WRITER: "#525252" },
  },
}

// Breakpoint presets
export const SCREEN = {
  MOBILE: { WIDTH: 480, COLS: 12 },
  TABLET: { WIDTH: 768, COLS: 6 },
  PC: { WIDTH: 1024, COLS: 4 },
  LARGE: { WIDTH: 1440, COLS: 3 },
}

// EXIF default exposure caps
export const EXIF = { APERTURE: 100, EXPOSURE: 1000 }

// Default policy contact
export const POLICY = { NAME: "sirini", EMAIL: "sirini@gmail.com" }

// Default currency
export const CURRENCY = "krw" // usb, cny, jpy, eur ...

Object.freeze(TSBOARD)
Object.freeze(COLOR)
Object.freeze(SCREEN)
Object.freeze(POLICY)
