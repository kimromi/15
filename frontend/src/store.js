import Vue from 'vue';
import Vuex from 'vuex';

Vue.use(Vuex);

const state = {
  date: ''
};
const actions = {
  changeDate({ commit }, date) {
    commit('changeDate', date);
  },
};
const getters = {
  date: state => state.date
};
const mutations = {
  changeDate(state, date) {
    state.date = date;
  },
};

const store = new Vuex.Store({
  state,
  getters,
  actions,
  mutations
});
export default store;
