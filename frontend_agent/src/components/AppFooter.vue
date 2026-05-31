<script setup>
</script>

<template>
  <footer class="app-footer">
    <div class="footer-inner">
      <div class="footer-grid">
        <div class="footer-col">
          <h4 class="footer-heading">新手指南</h4>
          <ul>
            <li><a href="#">如何注册</a></li>
            <li><a href="#">如何下单</a></li>
            <li><a href="#">支付方式</a></li>
            <li><a href="#">配送说明</a></li>
          </ul>
        </div>
        <div class="footer-col">
          <h4 class="footer-heading">售后服务</h4>
          <ul>
            <li><a href="#">退换货政策</a></li>
            <li><a href="#">退款说明</a></li>
            <li><a href="#">联系客服</a></li>
            <li><a href="#">投诉建议</a></li>
          </ul>
        </div>
        <div class="footer-col">
          <h4 class="footer-heading">关于当当</h4>
          <ul>
            <li><a href="#">公司介绍</a></li>
            <li><a href="#">加入我们</a></li>
            <li><a href="#">合作伙伴</a></li>
            <li><a href="#">广告服务</a></li>
          </ul>
        </div>
        <div class="footer-col footer-col-wide">
          <h4 class="footer-heading">联系我们</h4>
          <p class="footer-contact">客服热线：400-106-6666</p>
          <p class="footer-contact">服务时间：9:00 - 21:00</p>
          <p class="footer-contact">邮箱：service@dangdang.com</p>
        </div>
      </div>
      <div class="footer-bottom">
        <p>&copy; 2024 当当网 dangdang.com — 全球最大的中文网上书店</p>
        <p class="footer-icp">京ICP备xxxxxxxx号</p>
      </div>
    </div>
  </footer>
</template>

<style scoped>
.app-footer {
  background: #2C2C2C;
  color: rgba(255, 255, 255, 0.7);
  margin-top: var(--space-3xl);
}

.footer-inner {
  max-width: var(--max-width);
  margin: 0 auto;
  padding: var(--space-2xl) var(--space-md) var(--space-lg);
}

.footer-grid {
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  gap: var(--space-xl);
  padding-bottom: var(--space-xl);
  border-bottom: 1px solid rgba(255, 255, 255, 0.1);
}

.footer-heading {
  color: #fff;
  font-size: 0.95rem;
  font-weight: 600;
  margin-bottom: var(--space-md);
}

.footer-col ul {
  display: flex;
  flex-direction: column;
  gap: var(--space-sm);
}

.footer-col a {
  color: rgba(255, 255, 255, 0.55);
  font-size: 0.85rem;
  transition: color var(--transition);
}

.footer-col a:hover {
  color: var(--color-primary-light);
}

.footer-contact {
  font-size: 0.85rem;
  margin-bottom: var(--space-xs);
  color: rgba(255, 255, 255, 0.55);
}

.footer-bottom {
  text-align: center;
  padding-top: var(--space-lg);
  font-size: 0.8rem;
  color: rgba(255, 255, 255, 0.4);
  line-height: 1.8;
}

@media (max-width: 768px) {
  .footer-grid {
    grid-template-columns: repeat(2, 1fr);
    gap: var(--space-lg);
  }

  .footer-col-wide {
    grid-column: span 2;
  }
}
</style>
