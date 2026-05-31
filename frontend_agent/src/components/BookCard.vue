<script setup>
import { bookCover } from '../utils/constants.js'
import api from '../utils/api.js'

const props = defineProps({
  book: { type: Object, required: true }
})

const emit = defineEmits(['added'])

async function addToCart(e) {
  e.preventDefault()
  e.stopPropagation()
  try {
    await api.post('/cart/putCart', `bookId=${props.book.bookId}`)
    emit('added', props.book.bookName)
  } catch {}
}
</script>

<template>
  <div class="book-card card card-hover">
    <router-link :to="`/book/${book.bookId}`" class="book-card-link">
      <div class="book-cover-wrapper">
        <img
          :src="bookCover(book.cover)"
          :alt="book.bookName"
          class="book-cover"
          loading="lazy"
        />
        <div v-if="book.sale > 100" class="book-tag-hot">热销</div>
      </div>
      <div class="book-info">
        <h3 class="book-name">{{ book.bookName }}</h3>
        <p v-if="book.author" class="book-author">{{ book.author }}</p>
        <div class="book-price-row">
          <span class="book-price">&yen;{{ book.dprice }}</span>
          <del v-if="book.price > book.dprice" class="book-price-old">&yen;{{ book.price }}</del>
        </div>
        <div class="book-save" v-if="book.price > book.dprice">
          省 &yen;{{ (book.price - book.dprice).toFixed(1) }}
        </div>
      </div>
    </router-link>
    <button class="book-add-btn" @click="addToCart">加入购物车</button>
  </div>
</template>

<style scoped>
.book-card {
  display: flex;
  flex-direction: column;
  border: 1px solid var(--color-border-light);
}

.book-card-link {
  display: flex;
  flex-direction: column;
  flex: 1;
}

.book-cover-wrapper {
  position: relative;
  aspect-ratio: 3 / 4;
  overflow: hidden;
  background: #F8F8F6;
  display: flex;
  align-items: center;
  justify-content: center;
  padding: var(--space-lg);
}

.book-cover {
  max-width: 80%;
  max-height: 80%;
  object-fit: contain;
  transition: transform 0.35s ease;
}

.book-card:hover .book-cover {
  transform: scale(1.05);
}

.book-tag-hot {
  position: absolute;
  top: 8px;
  right: 8px;
  padding: 3px 10px;
  background: var(--color-accent);
  color: #fff;
  font-size: 0.7rem;
  font-weight: 600;
  border-radius: 10px;
}

.book-info {
  padding: var(--space-md);
  display: flex;
  flex-direction: column;
  flex: 1;
}

.book-name {
  font-size: 0.95rem;
  font-weight: 600;
  line-height: 1.4;
  margin-bottom: 4px;
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
  overflow: hidden;
  color: var(--color-text);
}

.book-author {
  font-size: 0.78rem;
  color: var(--color-text-muted);
  margin-bottom: var(--space-sm);
}

.book-price-row {
  display: flex;
  align-items: baseline;
  gap: var(--space-sm);
  margin-top: auto;
}

.book-price {
  font-size: 1.15rem;
  font-weight: 700;
  color: var(--color-primary);
}

.book-price-old {
  font-size: 0.78rem;
  color: var(--color-text-muted);
}

.book-save {
  font-size: 0.72rem;
  color: var(--color-success);
  margin-top: 2px;
  font-weight: 500;
}

.book-add-btn {
  margin: 0 var(--space-md) var(--space-md);
  padding: 10px 0;
  border: 1.5px solid var(--color-primary);
  border-radius: var(--radius-sm);
  background: transparent;
  color: var(--color-primary);
  font-weight: 500;
  font-size: 0.85rem;
  transition: all var(--transition);
}

.book-add-btn:hover {
  background: var(--color-primary);
  color: #fff;
}
</style>
