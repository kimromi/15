import Vue from 'vue';
import VueRouter from 'vue-router';

Vue.use(VueRouter);

import App from './components/app.vue';
import Settings from './components/contents/settings.vue';

const router = new VueRouter({
  routes: [
    {
      path: '/', component: App, children: [
        { path: 'settings', component: Settings }
      ]
    }
  ]
});
export default router;

