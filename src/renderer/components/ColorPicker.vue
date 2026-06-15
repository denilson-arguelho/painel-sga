<template>
  <div class="color-picker-wrapper">
    <div class="color-picker-label">
      <label class="label">{{ label }}</label>
      <div class="color-picker-controls">
        <div class="color-preview" :style="{ 'background-color': value }" @click="togglePicker"></div>
        <input 
          type="text" 
          class="input color-hex-input" 
          :value="value"
          @input="updateColor"
          placeholder="#000000"
        >
        <button type="button" class="button is-small" @click="togglePicker" title="Abrir seletor">
          <span class="icon">
            <i class="fa fa-palette"></i>
          </span>
        </button>
      </div>
    </div>

    <!-- Color Picker Dropdown -->
    <div class="color-picker-dropdown" v-if="showPicker" @click.stop>
      <!-- Color Grid -->
      <div class="color-grid">
        <div 
          v-for="color in colorPresets" 
          :key="color"
          class="color-option"
          :style="{ 'background-color': color }"
          :class="{ 'is-selected': value === color }"
          @click="selectColor(color)"
          :title="color">
        </div>
      </div>

      <!-- Custom Color Input -->
      <div class="custom-color-section">
        <h4 class="has-text-weight-bold is-size-7">Cor Personalizada</h4>
        <div class="field">
          <input 
            type="color" 
            class="color-native-picker"
            :value="value"
            @input="updateColorFromNative"
          >
        </div>
      </div>

      <!-- Recent Colors -->
      <div class="recent-colors" v-if="recentColors.length">
        <h4 class="has-text-weight-bold is-size-7">Cores Recentes</h4>
        <div class="color-grid">
          <div 
            v-for="color in recentColors" 
            :key="color"
            class="color-option"
            :style="{ 'background-color': color }"
            :class="{ 'is-selected': value === color }"
            @click="selectColor(color)"
            :title="color">
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: 'ColorPicker',
  props: {
    value: {
      type: String,
      default: '#000000'
    },
    label: {
      type: String,
      default: 'Cor'
    }
  },
  data () {
    return {
      showPicker: false,
      recentColors: [],
      colorPresets: [
        // Neutrals
        '#000000', '#FFFFFF', '#F5F5F5', '#E8E8E8',
        // Blues
        '#0066CC', '#0099FF', '#00CCFF', '#66D9FF',
        // Greens
        '#00AA00', '#00CC00', '#66FF66', '#99FF99',
        // Reds
        '#CC0000', '#FF0000', '#FF6666', '#FF9999',
        // Oranges
        '#FF6600', '#FF9900', '#FFCC00', '#FFDD99',
        // Purples
        '#9900CC', '#CC00FF', '#DD99FF', '#EE99FF',
        // Grays
        '#333333', '#666666', '#999999', '#CCCCCC'
      ]
    }
  },
  methods: {
    togglePicker () {
      this.showPicker = !this.showPicker
    },
    closePicker () {
      this.showPicker = false
    },
    selectColor (color) {
      this.$emit('input', color)
      this.addToRecentColors(color)
      this.closePicker()
    },
    updateColor (event) {
      let color = event.target.value
      if (!color.startsWith('#')) {
        color = '#' + color
      }
      if (this.isValidHex(color)) {
        this.$emit('input', color)
        this.addToRecentColors(color)
      }
    },
    updateColorFromNative (event) {
      const color = event.target.value
      this.$emit('input', color)
      this.addToRecentColors(color)
    },
    isValidHex (color) {
      return /^#[0-9A-F]{6}$/i.test(color)
    },
    addToRecentColors (color) {
      if (!this.recentColors.includes(color)) {
        this.recentColors.unshift(color)
        if (this.recentColors.length > 8) {
          this.recentColors.pop()
        }
      }
    }
  },
  mounted () {
    document.addEventListener('click', this.closePicker)
  },
  beforeDestroy () {
    document.removeEventListener('click', this.closePicker)
  }
}
</script>

<style lang="sass" scoped>
.color-picker-wrapper
  position: relative
  margin-bottom: 1rem

.color-picker-label
  .label
    margin-bottom: 0.5rem

.color-picker-controls
  display: flex
  gap: 0.5rem
  align-items: center

.color-preview
  width: 3rem
  height: 2.5rem
  border: 2px solid #ddd
  border-radius: 4px
  cursor: pointer
  transition: all 0.2s ease
  flex-shrink: 0

  &:hover
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.2)
    border-color: #999

.color-hex-input
  font-family: monospace
  font-size: 0.9rem
  flex: 1

.color-picker-dropdown
  position: absolute
  top: 100%
  left: 0
  background: white
  border: 1px solid #ddd
  border-radius: 4px
  padding: 1rem
  margin-top: 0.5rem
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15)
  z-index: 1000
  min-width: 280px

.color-grid
  display: grid
  grid-template-columns: repeat(4, 1fr)
  gap: 0.5rem
  margin-bottom: 1rem

.color-option
  width: 100%
  aspect-ratio: 1
  border: 2px solid transparent
  border-radius: 4px
  cursor: pointer
  transition: all 0.2s ease

  &:hover
    transform: scale(1.1)
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.2)

  &.is-selected
    border-color: #333
    box-shadow: inset 0 0 0 2px white, 0 0 0 4px #333

.custom-color-section
  border-top: 1px solid #eee
  padding-top: 1rem
  margin-bottom: 1rem

  h4
    margin-bottom: 0.5rem

.color-native-picker
  width: 100%
  height: 2.5rem
  border: 1px solid #ddd
  border-radius: 4px
  cursor: pointer

.recent-colors
  border-top: 1px solid #eee
  padding-top: 1rem

  h4
    margin-bottom: 0.5rem
</style>
