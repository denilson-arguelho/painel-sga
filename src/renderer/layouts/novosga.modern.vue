<template>
  <div class="novosga-modern layout-content" :style="{ 'background-color': color('pageBgColor'), 'color': color('pageFontColor') }">
    <!-- Header -->
    <header class="modern-header" :style="{ 'background-color': color('headerBgColor', 'pageBgColor') }">
      <div class="header-content">
        <div class="logo-section">
          <img :src="logoUrl" class="logo" alt="Logo">
          <div class="header-info" v-if="config.themeOptions.footerText">
            <h1>{{ config.themeOptions.footerText }}</h1>
          </div>
        </div>
        <div class="date-section">
          <clock 
            :locale="config.locale" 
            :dateFormat="'date_format'|trans" 
            :fontColor="color('headerFontColor', 'pageFontColor')"
            class="header-clock">
          </clock>
        </div>
      </div>
    </header>

    <!-- Main Content -->
    <div class="modern-container">
      <!-- Featured Area -->
      <div class="featured-area">
        <featured 
          :message="lastMessage" 
          v-if="lastMessage" 
          :fontColor="color('featuredFontColor', 'pageFontColor')">
        </featured>
        <div class="empty-state" v-else>
          <p>{{ 'empty.waiting'|trans }}</p>
        </div>
      </div>

      <!-- Sidebar -->
      <aside class="modern-sidebar" :style="{ 'background-color': color('sidebarBgColor'), 'color': color('sidebarFontColor') }">
        <!-- History Section -->
        <div class="sidebar-section history-section">
          <h2 class="sidebar-title">{{ 'history.title'|trans }}</h2>
          <div class="history-content">
            <history
              v-if="lastMessage"
              :messages="messages"
              :fontColorNormal="config.historyFontColorNormal || config.sidebarFontColorNormal"
              :fontColorPriority="config.historyFontColorPriority || config.sidebarFontColorPriority">
            </history>
            <div class="empty-history" v-else>
              <p>{{ 'empty.history'|trans }}</p>
            </div>
          </div>
        </div>

        <!-- Clock Section -->
        <div class="sidebar-section clock-section" :style="{ 'background-color': color('clockBgColor'), 'color': color('clockFontColor') }">
          <clock 
            :locale="config.locale" 
            :dateFormat="'date_format'|trans" 
            :fontColor="color('clockFontColor')"
            class="sidebar-clock">
          </clock>
        </div>
      </aside>
    </div>
  </div>
</template>

<script>
  import Clock from '@/components/Clock.vue'
  import Featured from '@/components/Featured.vue'
  import History from '@/components/History.vue'
  import audio from '@/services/audio'
  import speech from '@/services/speech'

  export default {
    name: 'Modern',
    components: {
      Clock,
      Featured,
      History
    },
    data () {
      return {
        isCalling: false,
        lastMessage: {},
        messageQueue: []
      }
    },
    computed: {
      messages () {
        return this.$store.getters.history
      },
      message () {
        return this.$store.getters.message
      },
      config () {
        return this.$store.state.config
      },
      logoUrl () {
        return this.config.themeOptions.logo || 'static/images/logo.png'
      }
    },
    methods: {
      call () {
        this.messageQueue.push(this.message)
        if (!this.isCalling) {
          this.playAudio()
        }
      },
      playAudio () {
        if (this.isCalling || this.messageQueue.length === 0) {
          return
        }
        this.isCalling = true
        this.lastMessage = this.messageQueue.shift()
        audio.playAlert(this.config.alert)
          .then(() => {
            if (!this.config.speech) {
              return Promise.resolve()
            }
            let texts = ['Senha']
            this.message.$data.siglaSenha.split('').forEach(char => texts.push(char))
            texts.push(this.message.$data.numeroSenha)
            texts.push(this.message.$data.local)
            texts.push(this.message.$data.numeroLocal)
            return speech.speechAll(texts, this.config.locale)
          })
          .then(() => {
            this.isCalling = false
            this.playAudio()
          })
      },
      color (prefix, fallback) {
        const peso = this.lastMessage.$data ? this.lastMessage.$data.peso : 0
        const suffix = peso > 0 ? 'Priority' : 'Normal'
        return this.config[prefix + suffix] || this.config[fallback + suffix]
      }
    },
    watch: {
      message () {
        this.call()
      }
    }
  }
</script>

<style lang="sass">
  .novosga-modern
    .layout-content
      position: fixed
      width: 100%
      height: 100%
      display: flex
      flex-direction: column
      overflow: hidden

    .modern-header
      flex: 0 0 auto
      padding: 1.5rem 2rem
      border-bottom: 1px solid rgba(0, 0, 0, 0.1)
      box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1)

      .header-content
        display: flex
        justify-content: space-between
        align-items: center
        max-width: 100%

      .logo-section
        display: flex
        align-items: center
        gap: 1.5rem

        .logo
          height: 4rem
          width: auto

        .header-info
          h1
            margin: 0
            font-size: 1.5rem
            font-weight: 600
            letter-spacing: 0.5px

      .date-section
        text-align: right

      .header-clock
        .time
          span
            font-size: 2rem
            font-weight: bold
          span.seconds
            font-size: 1.5rem
            opacity: 0.7
        .date
          span
            font-size: 0.95rem
            margin-top: 0.5rem
            display: block

    .modern-container
      flex: 1
      display: flex
      gap: 0
      overflow: hidden

    .featured-area
      flex: 1
      display: flex
      align-items: center
      justify-content: center
      padding: 2rem
      overflow-y: auto

      .featured-message
        text-align: center
        width: 100%

        .title
          font-size: 15vw
          font-weight: 700
          line-height: 1.1
          margin: 0
          letter-spacing: -2px

        .subtitle
          font-size: 6vw
          margin: 1rem 0 0 0
          opacity: 0.9
          font-weight: 500

        .description
          font-size: 5vw
          margin: 0.5rem 0 0 0
          opacity: 0.8
          font-weight: 400

      .empty-state
        text-align: center
        opacity: 0.5
        font-size: 1.5rem
        font-style: italic

    .modern-sidebar
      flex: 0 0 25%
      display: flex
      flex-direction: column
      border-left: 1px solid rgba(0, 0, 0, 0.1)
      overflow: hidden

      .sidebar-section
        display: flex
        flex-direction: column
        padding: 1.5rem
        overflow-y: auto

      .history-section
        flex: 1
        border-bottom: 1px solid rgba(0, 0, 0, 0.1)

      .clock-section
        flex: 0 0 auto
        justify-content: center
        align-items: center

      .sidebar-title
        margin: 0 0 1rem 0
        font-size: 1.1rem
        font-weight: 600
        text-transform: uppercase
        letter-spacing: 1px
        opacity: 0.9

      .history-content
        flex: 1
        overflow-y: auto

      .empty-history
        text-align: center
        opacity: 0.5
        font-style: italic
        font-size: 0.95rem

      .history
        .message
          background-color: rgba(0, 0, 0, 0.05)
          border-left: 4px solid currentColor
          padding: 0.75rem
          margin-bottom: 0.75rem
          border-radius: 4px
          transition: all 0.2s ease

          &:hover
            background-color: rgba(0, 0, 0, 0.08)
            transform: translateX(4px)

          span
            display: block
            text-align: left

          .title
            font-size: 1.1rem
            font-weight: 600
            margin-bottom: 0.25rem

          .subtitle
            font-size: 0.9rem
            opacity: 0.8
            font-style: italic

      .sidebar-clock
        text-align: center

        .time
          span
            font-size: 3rem
            font-weight: bold
            display: block
            line-height: 1

          span.seconds
            font-size: 1.5rem
            opacity: 0.7

        .date
          span
            font-size: 1rem
            margin-top: 0.5rem
            display: block

    // Responsive adjustments
    @media (max-width: 1024px)
      .modern-sidebar
        flex: 0 0 30%

      .featured-area
        .featured-message
          .title
            font-size: 12vw

          .subtitle
            font-size: 5vw

          .description
            font-size: 4vw

    @media (max-width: 768px)
      .modern-container
        flex-direction: column

      .modern-sidebar
        flex: 0 0 auto
        max-height: 30vh
        border-left: none
        border-top: 1px solid rgba(0, 0, 0, 0.1)

      .featured-area
        .featured-message
          .title
            font-size: 10vw

          .subtitle
            font-size: 4vw

          .description
            font-size: 3vw

      .modern-header
        .header-content
          flex-direction: column
          gap: 1rem

        .logo-section
          width: 100%

        .date-section
          text-align: center
          width: 100%
</style>
