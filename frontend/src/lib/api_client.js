import axios from 'axios';

export default class ApiClient {
  static async records(date) {
    return this.format(await this.client().get(`api/v1/records/${date}`), 'records');
  }

  static async createRecord(date, time, taskId) {
    const params = {
      at: `${date} ${time}:00`,
      task_id: taskId
    };
    return this.format(await this.client().post('api/v1/records', {record: params}));
  }

  static async currentTeam() {
    return this.format(await this.client().get('api/v1/team'), 'currentTeam');
  }

  static async teams() {
    return this.format(await this.client().get('api/v1/teams'), 'teams');
  }

  static async deleteTeam() {
    return this.format(await this.client().delete(`api/v1/team`));
  }

  static async tasks() {
    return this.format(await this.client().get('api/v1/tasks'), 'tasks');
  }

  static async createTask(params) {
    return this.format(await this.client().post('api/v1/tasks', {task: params}));
  }

  static async updateTask(id, params) {
    return this.format(await this.client().patch(`api/v1/tasks/${id}`, {task: params}));
  }

  static async deleteTask(id) {
    return this.format(await this.client().patch(`api/v1/tasks/${id}`, {task: {deleted: 'deleted'}}));
  }

  static async members() {
    return this.format(await this.client().get('api/v1/members'), 'members');
  }

  static async invitation() {
    return this.format(await this.client().get('api/v1/invitation'), 'invitation');
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
