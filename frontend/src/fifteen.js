import Vue from 'vue';
import router from './router';
import store from './store';

import { VTooltip, VPopover } from 'v-tooltip';
Vue.directive('tooltip', VTooltip);
Vue.component('v-popover', VPopover);

export default new Vue({ router, store }).$mount('#app');
