import Vue from 'vue';
import Vuex from 'vuex';

Vue.use(Vuex);

const state = {
  date: '',
  tasks: []
};
const actions = {
  changeDate({ commit }, date) {
    commit('changeDate', date);
  },
  setTasks({ commit }, tasks) {
    commit('setTasks', tasks);
  },
  addTask({ commit }, task) {
    commit('addTask', task);
  },
  deleteTask({ commit }, taskId) {
    commit('deleteTask', taskId);
  },
};
const getters = {
  date: state => state.date,
  tasks: state => state.tasks
};
const mutations = {
  changeDate(state, date) {
    state.date = date;
  },
  setTasks(state, tasks) {
    state.tasks = tasks;
  },
  addTask(state, task) {
    state.tasks.push(task);
  },
  deleteTask(state, taskId) {
    state.tasks.some((task, i) => {
      if (task.id == taskId) state.tasks.splice(i, 1);
    });
  },
};

const store = new Vuex.Store({
  state,
  getters,
  actions,
  mutations
});
export default store;
