<template>
  <div class="time-schedule">
    <div class="percentage">
      <div class="progress">
        <div v-for="p in percentages" :key="p.task" class="progress-bar" :style="{ width: p.percentage + '%', 'background-color': p.color }"></div>
      </div>
    </div>

    <div class="row time-table">
      <div class="table-area col-xs-12 col-sm-8">
        <table class="table">
          <tr v-for="hour in hours" :key="hour">
            <td class="hour">{{ hour }} </td>
            <td v-for="minute in minutes" :key="minute" class="enter" @click="select(hour, minute)" :class="cellClass(hour, minute)" :style="cellStyle(hour, minute)">
              <span v-if="records[hour + ':' + minute]">{{ records[hour + ':' + minute].task.name }}</span>
              <span v-else>{{ minute }}-{{ parseInt(minute) + 15 }}</span>
            </td>
          </tr>
        </table>
      </div>
      <div class="enter-area col-xs-12 col-sm-4">
        <ul class="list-group tasks">
          <li class="list-group-item task" v-for="task in tasks" :key="task.id" @click="record(task)">
            <div class="task-color" :style="{ 'background-color': task.background_color }">
              &nbsp;
            </div>
            {{ task.name }}
          </li>
        </ul>
      </div>
    </div>
  </div>
</template>

<script>
  import { mapGetters } from 'vuex';
  import _ from 'underscore';
  import ApiClient from '../../../lib/api_client';

  export default {
    data: function() {
      return {
        hours: _.range(0, 24),
        minutes: ['00', '15', '30', '45'],
        records: {},
        selected: null,
        tasks: [],
        percentages: []
      };
    },
    computed: {
      ...mapGetters(['date'])
    },
    created: function() {
      this.initialize();
      this.dateChanged();
    },
    watch: {
      date: 'dateChanged',
      records: 'updateProgressBar'
    },
    methods: {
      initialize: function() {
        this.fetchTasks();
      },
      dateChanged: async function() {
        await this.fetchRecords();
      },
      fetchTasks: async function() {
        const { tasks, error } = await ApiClient.tasks();
        if (!error) {
          this.tasks = tasks;
        } else {
          this.error = error.message;
        }
      },
      fetchRecords: async function() {
        const { records, error } = await ApiClient.records(this.date);
        if (!error) {
          for (const record of records) {
            this.records = Object.assign({}, this.records, { [record.time]: record });
          }
        } else {
          this.error = error.message;
        }
      },
      time: function(hour, minute) {
        return `${hour}:${minute}`;
      },
      select: function(hour, minute) {
        this.selected = this.time(hour, minute);
      },
      cellClass: function(hour, minute) {
        const time = this.time(hour, minute);
        return {
          active: this.selected == time,
          yet: !this.records[time],
          recorded: !!this.records[time]
        };
      },
      cellStyle: function(hour, minute) {
        const time = this.time(hour, minute);
        if (!this.records[time]) {
          return null;
        } else {
          return { 'background-color': this.records[time].task.background_color || '#FFF' };
        }
      },
      record: async function(task) {
        if (this.selected) {
          this.records = Object.assign({}, this.records, { [this.selected]: {task: {name: task.name, background_color: task.background_color}}});
          const { error } = await ApiClient.createRecord(this.date, this.selected, task.id);
          if (error) {
            this.error = error.message;
          }
        }
      },
      updateProgressBar: function() {
        const counts = {};
        let allCount = Object.keys(this.records).length;
        for (const key in this.records) {
          const task = this.records[key].task_name;
          counts[task] = counts[task] ? counts[task] + 1 : 1;
        }

        const percentages = [];
        for (const task in counts) {
          percentages.push({
            task_name: task,
            percentage: (counts[task] / allCount) * 100,
            color: 'red'
          });
        }
        this.percentages = percentages;
      }
    }
  };
</script>

<style lang="scss">
  .time-schedule {
    height: 100%;
    padding: 110px 0 30px 0;

    .percentage {
      position: absolute;
      top: 70px;
      left: 0;
      padding: 0 30px 0 230px;
      width: 100%;
    }

    .time-table {
      height: 100%;

      .table-area {
        padding: 0;
        height: 100%;
        overflow-y: auto;

        table {
          width: 100%;

          tr {
            td {
              padding: 5px;
              font-size: 13px;
              cursor: pointer;
            }

            td.hour {
              width: 4%;
              text-align: right;
            }

            td.enter {
              width: 24%;
              text-align: center;
            }

            td.yet {
              color: #CCC;
              border: 1px dotted #BBB;
            }
            td.active {
              color: #FFF;
              background-color: #333;
              border: 1px solid #333;
            }
            td.recorded {
              color: #000;
              border: 1px solid #CCC;
              font-weight: bold;
            }
          }
        }
      }
    }

    .enter-area {
      height: 100%;
      overflow-y: auto;

      h2 {
        margin: 0;
      }
    }

    .task {
      cursor: pointer;

      .task-color {
        display: inline-block;
        width: 23px;
        height: 23px;
        border: 1px solid #DEDEDE;
        margin-right: 3px;
      }
    }
  }
</style>
