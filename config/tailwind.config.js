const defaultTheme = require('tailwindcss/defaultTheme')
const colors = require('tailwindcss/colors')

module.exports = {
  content: [
    './public/*.html',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*.{erb,haml,html,slim}'
  ],
  theme: {
    extend: {
      colors: {
        'azure-white': '#F2FDFF',
        'rich-black': '#0F1020',
        'light-purple': '#7353BA',
        'dark-purple': '#6A0973',
        'purple': '#6F2E97',
      },
    },
    fontFamily: {
        sans: ['Ubuntu', "sans-serif"],
    },
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/aspect-ratio'),
    require('@tailwindcss/typography'),
    require('@tailwindcss/container-queries'),
  ]
}
