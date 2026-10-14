import { createApp } from 'vue'
import App from './App.vue'
import { connect } from './net'
import './style.css'

connect()
createApp(App).mount('#app')
