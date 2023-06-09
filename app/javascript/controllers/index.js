// This file is auto-generated by ./bin/rails stimulus:manifest:update
// Run that command whenever you add a new controller or create them with
// ./bin/rails generate stimulus controllerName

import { application } from "./application"


import FlatpickrController from "./flatpickr_controller"
application.register("flatpickr", FlatpickrController)

import HelloController from "./hello_controller"
application.register("hello", HelloController)

import Autosave from 'stimulus-rails-autosave'
application.register('autosave', Autosave)

import Dropdown from 'stimulus-dropdown';
application.register('dropdown', Dropdown);
import MapController from "./map_controller"
application.register("map", MapController)
import Notification from 'stimulus-notification'
application.register('notification', Notification)

import CharacterCounter from 'stimulus-character-counter'
application.register('character-counter', CharacterCounter)

import Reveal from 'stimulus-reveal-controller'
application.register('reveal', Reveal)

