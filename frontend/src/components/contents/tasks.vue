<template>
  <div class="tasks">
    <h1>Tasks</h1>

    <div class="alert alert-warning" role="alert" v-show="error">
      {{ error }}
    </div>

    <form class="form-group" @submit.prevent="add">
      <input type="text" class="form-control" placeholder="Add task" v-model="name">
    </form>

    <ul class="list-group">
      <li class="list-group-item" v-for="task in tasks" :key="task.id">
        <div class="clearfix">
          <div class="pull-left">
            <div class="selected-color" @click="selectColorPicker(task.id)" :style="{ 'background-color': task.background_color }">
              &nbsp;
            </div>
            <div class="color-picker">
              <compact-picker v-show="isShowColorPicker(task.id)" :value="colors" @input="pickColor"></compact-picker>
            </div>
            {{ task.name }}
          </div>
          <div class="pull-right">
            <i class="fa fa-trash" @click="destroy(task.id)"></i>
          </div>
        </div>
      </li>
    </ul>
  </div>
</template>

<script>
  import ApiClient from '../../lib/api_client';
  import { Compact } from 'vue-color';

  export default {
    components: {
      'compact-picker': Compact
    },
    data: function() {
      return {
        error: null,
        name: null,
        tasks: [],
        selectedId: null,
        colors: { hex: '#aaaaaa' }
      };
    },
    created: async function() {
      let { tasks, error } = await ApiClient.tasks();
      if (!error) {
        this.tasks = tasks;
      } else {
        this.error = error.message;
      }
    },
    methods: {
      add: async function() {
        if (this.name) {
          const { data, error } = await ApiClient.createTask({name: this.name});
          if (!error) {
            this.tasks.push(data);
            this.name = '';
            this.error = '';
          } else {
            this.error = error.message;
          }
        }
      },
      destroy: async function(id) {
        const { error } = await ApiClient.destroyTask(id);
        if (!error) {
          this.tasks.some((task, i) => {
            if (task.id == id) this.tasks.splice(i, 1);
          });
          this.error = '';
        } else {
          this.error = error.message;
        }
      },
      isShowColorPicker: function(id) {
        return this.selectedId == id;
      },
      selectColorPicker: function(id) {
        this.selectedId = this.selectedId == id ? null: id;
      },
      pickColor: async function(color) {
        for (const i in this.tasks) {
          const task = this.tasks[i];
          if (task.id == this.selectedId) {
            task.background_color = color.hex;
            this.tasks = Object.assign([], this.tasks, task);

            const { error } = await ApiClient.updateTask(this.selectedId, {background_color: color.hex});
            if (error) {
              this.error = error.message;
            }

            this.selectedId = null;
          }
        }
      },
    }
  };
</script>

<style lang="scss">
  .tasks {
    .selected-color {
      display: inline-block;
      width: 23px;
      height: 23px;
      border: 1px solid #DEDEDE;

      &:hover {
        cursor: pointer;
      }
    }

    .color-picker {
      display: inline-block;
      position: relative;
      margin-right: 5px;

      .vc-compact {
        z-index: 100000;
        position: absolute;
        top : 10px;
        left: -29px;
        width: 375px;
        padding: 10px 0px 4px 10px;

        .vc-compact-color-item {
          width: 25px;
          height: 25px;
        }
      }
    }
  }
</style>
