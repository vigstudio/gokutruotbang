import { createApp } from 'vue'
import { installErrorReporting } from './clientlog'
import App from './App.vue'
import { connect } from './net'
import './style.css'

connect()
installErrorReporting()
createApp(App).mount('#app')
