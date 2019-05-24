import React from 'react';
import ReactDOM from 'react-dom';
import App from './components/app';
import configureStore from './store/store';
import * as UserAPIUtil from './util/user_api_util';
import { fetchUsers } from './actions/user_actions';
import { fetchWarble } from './actions/warble_actions';


document.addEventListener('DOMContentLoaded', () => {
  const store = configureStore();

  //TESTING!!!//
  window.getState = store.getState;
  window.dispatch = store.dispatch;
  window.UserAPIUtil = {};
  window.UserAPIUtil.fetchUsers = UserAPIUtil.fetchUsers;
  window.fetchUsers = fetchUsers;
  window.fetchWarble = fetchWarble;
  //TESTING!!!//

  const root = document.getElementById('root');
  ReactDOM.render(<App store={store} />, root);
});