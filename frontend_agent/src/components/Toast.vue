<script setup>
defineProps({
  toasts: { type: Array, default: () => [] }
})
</script>

<template>
  <div class="toast-container">
    <div
      v-for="t in toasts"
      :key="t.id"
      class="toast"
      :class="`toast-${t.type}`"
    >
      {{ t.message }}
    </div>
  </div>
</template>
