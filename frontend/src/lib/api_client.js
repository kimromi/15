import axios from 'axios';

export default class ApiClient {
  static async records(date) {
    return this.format(await this.client().get(`api/v1/records/${date}`), 'records');
  }

  static async createRecord(date, time, task_name) {
    const params = {
      at: `${date} ${time}:00`,
      task_name: task_name
    };
    return this.format(await this.client().post('api/v1/records', {record: params}));
  }

  static async currentTeam() {
    return this.format(await this.client().get('api/v1/team'), 'currentTeam');
  }

  static async teams() {
    return this.format(await this.client().get('api/v1/teams'), 'teams');
  }

  static async tasks() {
    return this.format(await this.client().get('api/v1/tasks'), 'tasks');
  }

  static async createTask(params) {
    return this.format(await this.client().post('api/v1/tasks', {task: params}));
  }

  static async destroyTask(id) {
    return this.format(await this.client().delete(`api/v1/tasks/${id}`));
  }

  static client() {
    const client = axios.create();
    client.interceptors.response.use((response) => {
      return Promise.resolve({
        data: response.data
      });
    }, (error) => {
      return Promise.resolve({
        error: {
          status: error.response.status,
          message: error.response.data.message
        }
      });
    });
    return client;
  }

  static format(response, key = 'data') {
    return { [key]: response.data, error: response.error };
  }
}
