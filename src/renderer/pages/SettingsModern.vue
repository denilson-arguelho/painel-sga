<template>
  <div class="settings-modern">
    <div class="settings-container">
      <!-- Sidebar Navigation -->
      <aside class="settings-sidebar">
        <div class="sidebar-header">
          <img src="static/images/logo.png" alt="Logo">
          <router-link to="/" class="back-link">
            <span class="icon">
              <i class="fa fa-chevron-left"></i>
            </span>
            {{ 'menu.go_back'|trans }}
          </router-link>
        </div>

        <nav class="settings-nav">
          <div class="nav-section">
            <p class="nav-label">{{ 'menu.general'|trans }}</p>
            <ul class="nav-list">
              <li>
                <a @click="showTab('interface')" :class="{ 'is-active': tab === 'interface' }">
                  <span class="icon"><i class="fa fa-paint-brush"></i></span>
                  {{ 'menu.interface'|trans }}
                </a>
              </li>
              <li>
                <a @click="showTab('server')" :class="{ 'is-active': tab === 'server' }">
                  <span class="icon"><i class="fa fa-server"></i></span>
                  {{ 'menu.server'|trans }}
                </a>
              </li>
              <li v-if="unities.length">
                <a @click="showTab('services')" :class="{ 'is-active': tab === 'services' }">
                  <span class="icon"><i class="fa fa-cogs"></i></span>
                  {{ 'menu.services'|trans }}
                </a>
              </li>
              <li>
                <a @click="showTab('sound')" :class="{ 'is-active': tab === 'sound' }">
                  <span class="icon"><i class="fa fa-volume-up"></i></span>
                  {{ 'menu.sound'|trans }}
                </a>
              </li>
            </ul>
          </div>
        </nav>
      </aside>

      <!-- Main Content -->
      <main class="settings-main">
        <div class="settings-header">
          <h1 class="title">{{ 'settings.title'|trans }}</h1>
          <p class="subtitle">{{ 'settings.subtitle'|trans }}</p>
        </div>

        <!-- Interface Tab -->
        <form @submit.prevent="save" v-if="tab === 'interface'" class="settings-form">
          <!-- Basic Settings -->
          <section class="settings-section">
            <h2 class="section-title">{{ 'settings.interface.basic'|trans }}</h2>
            
            <div class="form-grid">
              <div class="form-group">
                <label class="label">
                  <i class="fa fa-globe"></i>
                  {{ 'settings.label.locale'|trans }}
                </label>
                <div class="control">
                  <span class="select is-fullwidth">
                    <select v-model="config.locale">
                      <option value="en">English</option>
                      <option value="es">Español</option>
                      <option value="pt_BR">Português (Brasil)</option>
                    </select>
                  </span>
                </div>
              </div>

              <div class="form-group">
                <label class="label">
                  <i class="fa fa-paint-brush"></i>
                  {{ 'settings.label.theme'|trans }}
                </label>
                <div class="control">
                  <span class="select is-fullwidth">
                    <select v-model="config.theme" @change="changeTheme">
                      <option :value="theme.id" v-for="theme in themes" :key="theme.id">
                        {{ theme.name }}
                      </option>
                    </select>
                  </span>
                </div>
              </div>
            </div>
          </section>

          <!-- Theme Options -->
          <section class="settings-section" v-if="selectedTheme && selectedTheme.options.length">
            <h2 class="section-title">{{ 'settings.interface.theme_options'|trans }}</h2>
            
            <div class="form-grid">
              <div class="form-group" v-for="option in selectedTheme.options" :key="option.name">
                <label class="label">{{ option.label }}</label>
                <div class="control">
                  <input 
                    :type="option.type" 
                    :placeholder="option.placeholder" 
                    v-model="config.themeOptions[option.name]" 
                    class="input"
                  >
                </div>
              </div>
            </div>
          </section>

          <!-- Color Settings -->
          <section class="settings-section">
            <h2 class="section-title">{{ 'settings.interface.colors'|trans }}</h2>
            
            <!-- Page Colors -->
            <div class="color-group">
              <h3 class="color-group-title">{{ 'settings.interface.page_colors'|trans }}</h3>
              <div class="form-grid">
                <color-picker 
                  v-model="config.pageBgColorNormal"
                  :label="'settings.label.page_bg_color_normal'|trans">
                </color-picker>
                <color-picker 
                  v-model="config.pageFontColorNormal"
                  :label="'settings.label.page_font_color_normal'|trans">
                </color-picker>
                <color-picker 
                  v-model="config.pageBgColorPriority"
                  :label="'settings.label.page_bg_color_priority'|trans">
                </color-picker>
                <color-picker 
                  v-model="config.pageFontColorPriority"
                  :label="'settings.label.page_font_color_priority'|trans">
                </color-picker>
              </div>
            </div>

            <!-- Featured Colors -->
            <div class="color-group">
              <h3 class="color-group-title">{{ 'settings.interface.featured_colors'|trans }}</h3>
              <div class="form-grid">
                <color-picker 
                  v-model="config.featuredFontColorNormal"
                  :label="'settings.label.featured_font_color_normal'|trans">
                </color-picker>
                <color-picker 
                  v-model="config.featuredFontColorPriority"
                  :label="'settings.label.featured_font_color_priority'|trans">
                </color-picker>
              </div>
            </div>

            <!-- History Colors -->
            <div class="color-group">
              <h3 class="color-group-title">{{ 'settings.interface.history_colors'|trans }}</h3>
              <div class="form-grid">
                <color-picker 
                  v-model="config.historyFontColorNormal"
                  :label="'settings.label.history_font_color_normal'|trans">
                </color-picker>
                <color-picker 
                  v-model="config.historyFontColorPriority"
                  :label="'settings.label.history_font_color_priority'|trans">
                </color-picker>
              </div>
            </div>

            <!-- Sidebar Colors -->
            <div class="color-group">
              <h3 class="color-group-title">{{ 'settings.interface.sidebar_colors'|trans }}</h3>
              <div class="form-grid">
                <color-picker 
                  v-model="config.sidebarBgColorNormal"
                  :label="'settings.label.sidebar_bg_color_normal'|trans">
                </color-picker>
                <color-picker 
                  v-model="config.sidebarFontColorNormal"
                  :label="'settings.label.sidebar_font_color_normal'|trans">
                </color-picker>
                <color-picker 
                  v-model="config.sidebarBgColorPriority"
                  :label="'settings.label.sidebar_bg_color_priority'|trans">
                </color-picker>
                <color-picker 
                  v-model="config.sidebarFontColorPriority"
                  :label="'settings.label.sidebar_font_color_priority'|trans">
                </color-picker>
              </div>
            </div>

            <!-- Footer Colors -->
            <div class="color-group">
              <h3 class="color-group-title">{{ 'settings.interface.footer_colors'|trans }}</h3>
              <div class="form-grid">
                <color-picker 
                  v-model="config.footerBgColorNormal"
                  :label="'settings.label.footer_bg_color_normal'|trans">
                </color-picker>
                <color-picker 
                  v-model="config.footerFontColorNormal"
                  :label="'settings.label.footer_font_color_normal'|trans">
                </color-picker>
                <color-picker 
                  v-model="config.footerBgColorPriority"
                  :label="'settings.label.footer_bg_color_priority'|trans">
                </color-picker>
                <color-picker 
                  v-model="config.footerFontColorPriority"
                  :label="'settings.label.footer_font_color_priority'|trans">
                </color-picker>
              </div>
            </div>

            <!-- Clock Colors -->
            <div class="color-group">
              <h3 class="color-group-title">{{ 'settings.interface.clock_colors'|trans }}</h3>
              <div class="form-grid">
                <color-picker 
                  v-model="config.clockBgColorNormal"
                  :label="'settings.label.clock_bg_color_normal'|trans">
                </color-picker>
                <color-picker 
                  v-model="config.clockFontColorNormal"
                  :label="'settings.label.clock_font_color_normal'|trans">
                </color-picker>
                <color-picker 
                  v-model="config.clockBgColorPriority"
                  :label="'settings.label.clock_bg_color_priority'|trans">
                </color-picker>
                <color-picker 
                  v-model="config.clockFontColorPriority"
                  :label="'settings.label.clock_font_color_priority'|trans">
                </color-picker>
              </div>
            </div>

            <!-- Header Colors (New) -->
            <div class="color-group">
              <h3 class="color-group-title">{{ 'settings.interface.header_colors'|trans }}</h3>
              <div class="form-grid">
                <color-picker 
                  v-model="config.headerBgColorNormal"
                  :label="'settings.label.header_bg_color_normal'|trans">
                </color-picker>
                <color-picker 
                  v-model="config.headerFontColorNormal"
                  :label="'settings.label.header_font_color_normal'|trans">
                </color-picker>
                <color-picker 
                  v-model="config.headerBgColorPriority"
                  :label="'settings.label.header_bg_color_priority'|trans">
                </color-picker>
                <color-picker 
                  v-model="config.headerFontColorPriority"
                  :label="'settings.label.header_font_color_priority'|trans">
                </color-picker>
              </div>
            </div>
          </section>

          <!-- Form Actions -->
          <div class="form-actions">
            <button type="submit" class="button is-primary is-large">
              <span class="icon"><i class="fa fa-save"></i></span>
              <span>{{ 'settings.btn.save'|trans }}</span>
            </button>
          </div>
        </form>

        <!-- Server Tab -->
        <form @submit.prevent="save" v-if="tab === 'server'" class="settings-form">
          <section class="settings-section">
            <h2 class="section-title">{{ 'settings.server.connection'|trans }}</h2>
            
            <div class="form-group">
              <label class="label">{{ 'settings.label.server'|trans }}</label>
              <div class="control">
                <input 
                  class="input" 
                  type="url" 
                  placeholder="https://" 
                  v-model="config.server" 
                  @change="changeServer"
                >
              </div>
            </div>

            <div class="form-grid">
              <div class="form-group">
                <label class="label">{{ 'settings.label.username'|trans }}</label>
                <div class="control">
                  <input class="input" type="text" v-model="config.username">
                </div>
              </div>

              <div class="form-group">
                <label class="label">{{ 'settings.label.password'|trans }}</label>
                <div class="control">
                  <input class="input" type="password" v-model="config.password">
                </div>
              </div>
            </div>

            <div class="form-grid">
              <div class="form-group">
                <label class="label">{{ 'settings.label.client_id'|trans }}</label>
                <div class="control">
                  <input class="input" type="text" v-model="config.clientId">
                </div>
              </div>

              <div class="form-group">
                <label class="label">{{ 'settings.label.client_secret'|trans }}</label>
                <div class="control">
                  <input class="input" type="password" v-model="config.clientSecret">
                </div>
              </div>
            </div>
          </section>

          <div class="form-actions">
            <button type="submit" class="button is-primary is-large">
              <span class="icon"><i class="fa fa-save"></i></span>
              <span>{{ 'settings.btn.save'|trans }}</span>
            </button>
          </div>
        </form>

        <!-- Sound Tab -->
        <form @submit.prevent="save" v-if="tab === 'sound'" class="settings-form">
          <section class="settings-section">
            <h2 class="section-title">{{ 'settings.sound.alerts'|trans }}</h2>
            
            <div class="form-group">
              <label class="label">{{ 'settings.label.alert'|trans }}</label>
              <div class="control">
                <span class="select is-fullwidth">
                  <select v-model="config.alert">
                    <option :value="alert" v-for="(name, alert) in alerts" :key="alert">
                      {{ name }}
                    </option>
                  </select>
                </span>
              </div>
              <button type="button" class="button is-info is-outlined" @click="testAlert">
                <span class="icon"><i class="fa fa-play"></i></span>
                <span>{{ 'settings.btn.test_alert'|trans }}</span>
              </button>
            </div>

            <div class="form-group">
              <label class="checkbox">
                <input type="checkbox" v-model="config.speech">
                {{ 'settings.label.speech'|trans }}
              </label>
              <button 
                v-if="config.speech"
                type="button" 
                class="button is-info is-outlined" 
                @click="testSpeech"
              >
                <span class="icon"><i class="fa fa-play"></i></span>
                <span>{{ 'settings.btn.test_speech'|trans }}</span>
              </button>
            </div>
          </section>

          <div class="form-actions">
            <button type="submit" class="button is-primary is-large">
              <span class="icon"><i class="fa fa-save"></i></span>
              <span>{{ 'settings.btn.save'|trans }}</span>
            </button>
          </div>
        </form>

        <!-- Services Tab -->
        <form @submit.prevent="save" v-if="tab === 'services'" class="settings-form">
          <section class="settings-section">
            <h2 class="section-title">{{ 'settings.services.unity'|trans }}</h2>
            
            <div class="form-group">
              <label class="label">{{ 'settings.label.unity'|trans }}</label>
              <div class="control">
                <span class="select is-fullwidth">
                  <select v-model="config.unity" @change="loadServices">
                    <option :value="null">{{ 'select.unity'|trans }}</option>
                    <option :value="unity.id" v-for="unity in unities" :key="unity.id">
                      {{ unity.name }}
                    </option>
                  </select>
                </span>
              </div>
            </div>

            <div class="form-group" v-if="config.unity">
              <label class="label">{{ 'settings.label.services'|trans }}</label>
              <div class="services-list">
                <label class="checkbox" v-for="service in services" :key="service.id">
                  <input 
                    type="checkbox" 
                    :value="service.id"
                    v-model="config.services"
                  >
                  {{ service.name }}
                </label>
              </div>
            </div>
          </section>

          <div class="form-actions">
            <button type="submit" class="button is-primary is-large">
              <span class="icon"><i class="fa fa-save"></i></span>
              <span>{{ 'settings.btn.save'|trans }}</span>
            </button>
          </div>
        </form>
      </main>
    </div>
  </div>
</template>

<script>
  import ColorPicker from '@/components/ColorPicker.vue'
  import audio from '@/services/audio'
  import speech from '@/services/speech'
  import { log } from '@/util/functions'

  function load (ctx, isInit) {
    ctx.config = JSON.parse(JSON.stringify(ctx.$store.state.config))
    // defaults
    ctx.config.locale = ctx.config.locale || 'en'
    ctx.config.retries = ctx.config.retries || 5
    ctx.config.theme = ctx.config.theme || ctx.themes[0].id
    ctx.config.themeOptions = ctx.config.themeOptions || {}
    ctx.config.services = ctx.config.services || []
    ctx.config.alert = ctx.config.alert || audio.alertsAvailable.Default
    ctx.config.speech = !!ctx.config.speech

    // Color defaults
    ctx.config.pageBgColorNormal = ctx.config.pageBgColorNormal || '#FFFFFF'
    ctx.config.pageFontColorNormal = ctx.config.pageFontColorNormal || '#000000'
    ctx.config.pageBgColorPriority = ctx.config.pageBgColorPriority || '#FFFFFF'
    ctx.config.pageFontColorPriority = ctx.config.pageFontColorPriority || '#FF0000'
    ctx.config.featuredFontColorNormal = ctx.config.featuredFontColorNormal || '#000000'
    ctx.config.featuredFontColorPriority = ctx.config.featuredFontColorPriority || '#FF0000'
    ctx.config.historyFontColorNormal = ctx.config.historyFontColorNormal || '#000000'
    ctx.config.historyFontColorPriority = ctx.config.historyFontColorPriority || '#FF0000'
    ctx.config.sidebarBgColorNormal = ctx.config.sidebarBgColorNormal || '#4FC08D'
    ctx.config.sidebarFontColorNormal = ctx.config.sidebarFontColorNormal || '#000000'
    ctx.config.sidebarBgColorPriority = ctx.config.sidebarBgColorPriority || '#4FC08D'
    ctx.config.sidebarFontColorPriority = ctx.config.sidebarFontColorPriority || '#000000'
    ctx.config.footerBgColorNormal = ctx.config.footerBgColorNormal || '#F1F1F1'
    ctx.config.footerFontColorNormal = ctx.config.footerFontColorNormal || '#000000'
    ctx.config.footerBgColorPriority = ctx.config.footerBgColorPriority || '#F1F1F1'
    ctx.config.footerFontColorPriority = ctx.config.footerFontColorPriority || '#000000'
    ctx.config.clockBgColorNormal = ctx.config.clockBgColorNormal || '#44A075'
    ctx.config.clockFontColorNormal = ctx.config.clockFontColorNormal || '#000000'
    ctx.config.clockBgColorPriority = ctx.config.clockBgColorPriority || '#44A075'
    ctx.config.clockFontColorPriority = ctx.config.clockFontColorPriority || '#000000'
    ctx.config.headerBgColorNormal = ctx.config.headerBgColorNormal || '#F5F5F5'
    ctx.config.headerFontColorNormal = ctx.config.headerFontColorNormal || '#000000'
    ctx.config.headerBgColorPriority = ctx.config.headerBgColorPriority || '#F5F5F5'
    ctx.config.headerFontColorPriority = ctx.config.headerFontColorPriority || '#FF0000'

    if (ctx.$store.getters.isAuthenticated) {
      const forceLoad = (
        isInit ||
        !ctx.unities ||
        ctx.unities.length === 0
      )

      ctx.fetchUnities = forceLoad
      ctx.fetchServices = forceLoad

      if (ctx.$store.getters.isExpired) {
        log('token expired, trying to refresh')

        ctx.$store.dispatch('token').then(() => {
          log('token refreshed successfully!')
          ctx.loadData()
        }, () => {
          log('error on refresh token')
        })
      } else {
        ctx.loadData()
      }
    }

    ctx.initialClientId = ctx.config.clientId
    ctx.initialClientSecret = ctx.config.clientSecret
    ctx.initialUsername = ctx.config.username
    ctx.initialPassword = ctx.config.password
  }

  export default {
    name: 'SettingsModern',
    components: {
      ColorPicker
    },
    data () {
      return {
        tab: 'interface',
        config: {},
        initialClientId: null,
        initialClientSecret: null,
        initialUsername: null,
        initialPassword: null,
        fetchUnities: !this.unities,
        fetchServices: !this.services
      }
    },
    computed: {
      unities () {
        return this.$store.state.settings.unities
      },
      services () {
        return this.$store.state.settings.services
      },
      themes () {
        return this.$store.state.settings.availableThemes
      },
      selectedTheme () {
        return this.$store.getters.getTheme(this.config.theme)
      },
      alerts () {
        return audio.alertsAvailable
      },
      isCredentialChanged () {
        return (
          this.initialClientId !== this.config.clientId ||
          this.initialClientSecret !== this.config.clientSecret ||
          this.initialUsername !== this.config.username ||
          this.initialPassword !== this.config.password
        )
      }
    },
    methods: {
      showTab (tab) {
        this.tab = tab
      },
      changeTheme () {
        this.config.themeOptions = {}
      },
      changeServer () {
        this.config.unity = null
        this.fetchUnities = true
        this.fetchServices = false
      },
      loadData () {
        if (this.fetchUnities && this.config.server) {
          this.$store
            .dispatch('fetchUnities')
            .then(() => {}, (error) => {
              this.$swal('Oops!', error, 'error')
            })
          this.fetchUnities = false
        }

        if (this.fetchServices && this.config.unity) {
          this.$store.dispatch('fetchServices', this.config.unity)
          this.fetchServices = false
        }
      },
      loadServices () {
        this.$store.dispatch('fetchServices', this.config.unity)
      },
      save () {
        this.$store.dispatch('saveConfig', this.config)

        const token = (
          !this.$store.getters.isAuthenticated ||
          this.$store.getters.isExpired ||
          this.isCredentialChanged
        )

        let promise

        if (token) {
          promise = this.$store.dispatch('token')
        } else {
          promise = Promise.resolve()
        }

        promise.then(() => {
          this.$swal('Success', 'Configuration Ok', 'success')
          load(this, false)
        }, error => {
          this.$swal('Oops!', error, 'error')
        })
      },
      testAlert () {
        if (this.config.alert) {
          audio.playAlert(this.config.alert)
        }
      },
      testSpeech () {
        const lang = this.config.locale || 'pt-BR'
        log('Testing speech lang', lang)

        speech.speechAll([
          'Senha',
          '21',
          'mesa',
          '5'
        ], lang).then(() => {
          log('Testing end')
        }, (e) => {
          log('Testing error', e)
        })
      }
    },
    beforeMount () {
      load(this, true)
    }
  }
</script>

<style lang="sass" scoped>
.settings-modern
  background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%)
  min-height: 100vh
  padding: 0

.settings-container
  display: flex
  height: 100vh
  background: white

.settings-sidebar
  flex: 0 0 250px
  background: linear-gradient(180deg, #2c3e50 0%, #34495e 100%)
  color: white
  overflow-y: auto
  padding: 2rem 0
  box-shadow: 2px 0 8px rgba(0, 0, 0, 0.1)

  .sidebar-header
    padding: 0 1.5rem 2rem
    border-bottom: 1px solid rgba(255, 255, 255, 0.1)

    img
      width: 100%
      max-height: 60px
      margin-bottom: 1rem

    .back-link
      display: flex
      align-items: center
      gap: 0.5rem
      color: white
      text-decoration: none
      font-size: 0.95rem
      transition: all 0.2s ease

      &:hover
        opacity: 0.8
        transform: translateX(-4px)

      .icon
        display: flex
        align-items: center

.settings-nav
  .nav-section
    padding: 0 1rem

    .nav-label
      font-size: 0.8rem
      text-transform: uppercase
      letter-spacing: 1px
      opacity: 0.6
      padding: 1rem 0.5rem 0.5rem
      margin: 0

    .nav-list
      list-style: none
      padding: 0
      margin: 0

      li
        margin-bottom: 0.5rem

        a
          display: flex
          align-items: center
          gap: 0.75rem
          padding: 0.75rem 1rem
          color: rgba(255, 255, 255, 0.7)
          text-decoration: none
          border-radius: 4px
          cursor: pointer
          transition: all 0.2s ease

          .icon
            display: flex
            align-items: center
            width: 1.2rem

          &:hover
            background: rgba(255, 255, 255, 0.1)
            color: white

          &.is-active
            background: #3498db
            color: white
            font-weight: 600

.settings-main
  flex: 1
  overflow-y: auto
  padding: 3rem

.settings-header
  margin-bottom: 2rem

  .title
    font-size: 2rem
    font-weight: 700
    margin-bottom: 0.5rem
    color: #2c3e50

  .subtitle
    font-size: 1rem
    color: #7f8c8d
    margin: 0

.settings-form
  max-width: 1000px

.settings-section
  background: white
  padding: 2rem
  margin-bottom: 2rem
  border-radius: 8px
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05)

  .section-title
    font-size: 1.3rem
    font-weight: 600
    margin-bottom: 1.5rem
    color: #2c3e50
    padding-bottom: 1rem
    border-bottom: 2px solid #ecf0f1

.form-grid
  display: grid
  grid-template-columns: repeat(auto-fit, minmax(300px, 1fr))
  gap: 2rem

.form-group
  display: flex
  flex-direction: column

  .label
    font-weight: 600
    margin-bottom: 0.5rem
    color: #2c3e50
    display: flex
    align-items: center
    gap: 0.5rem

    i
      opacity: 0.6

  .control
    position: relative

  input[type="text"],
  input[type="url"],
  input[type="password"],
  input[type="email"],
  select
    padding: 0.75rem 1rem
    border: 2px solid #ecf0f1
    border-radius: 4px
    font-size: 1rem
    transition: all 0.2s ease

    &:focus
      border-color: #3498db
      box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.1)
      outline: none

  .checkbox
    display: flex
    align-items: center
    gap: 0.5rem
    cursor: pointer
    font-weight: 500
    color: #2c3e50

    input
      cursor: pointer

.color-group
  margin-bottom: 2rem
  padding-bottom: 2rem
  border-bottom: 1px solid #ecf0f1

  &:last-child
    border-bottom: none
    margin-bottom: 0
    padding-bottom: 0

  .color-group-title
    font-size: 1rem
    font-weight: 600
    color: #34495e
    margin-bottom: 1rem
    text-transform: uppercase
    letter-spacing: 0.5px

.services-list
  display: flex
  flex-direction: column
  gap: 0.75rem

  .checkbox
    display: flex
    align-items: center
    gap: 0.5rem
    padding: 0.5rem
    border-radius: 4px
    transition: all 0.2s ease

    &:hover
      background: #ecf0f1

.form-actions
  display: flex
  justify-content: flex-end
  gap: 1rem
  margin-top: 2rem

  .button
    padding: 0.75rem 2rem
    font-weight: 600
    border-radius: 4px
    transition: all 0.2s ease

    &:hover
      transform: translateY(-2px)
      box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15)

@media (max-width: 768px)
  .settings-container
    flex-direction: column

  .settings-sidebar
    flex: 0 0 auto
    max-height: 60px
    overflow-x: auto
    overflow-y: hidden
    padding: 0

    .sidebar-header
      display: none

    .settings-nav
      display: flex
      gap: 0

      .nav-section
        padding: 0
        display: flex
        gap: 0

        .nav-label
          display: none

        .nav-list
          display: flex
          gap: 0

          li
            margin-bottom: 0

            a
              padding: 1rem 1.5rem
              border-radius: 0
              white-space: nowrap

  .settings-main
    padding: 1.5rem

  .form-grid
    grid-template-columns: 1fr
    gap: 1rem

  .settings-header
    .title
      font-size: 1.5rem
</style>
