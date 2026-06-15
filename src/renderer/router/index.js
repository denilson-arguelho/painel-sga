import Vue from 'vue'
import Router from 'vue-router'

Vue.use(Router)

export default new Router({
  routes: [
    {
      path: '/',
      name: 'home',
      component: require('@/pages/Home').default
    },
    {
      path: '/settings-old',
      name: 'settings-old',
      component: require('@/pages/Settings').default
    },
    {
      path: '/settings',
      name: 'settings',
      component: require('@/pages/SettingsModern').default
    },
    {
      path: '*',
      redirect: '/'
    }
  ]
})
