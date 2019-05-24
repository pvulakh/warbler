import { RECEIVE_USERS, RECEIVE_USER } from "../../actions/user_actions";


export default (state = {}, action) => {
  const oldState = Object.freeze(state);
  switch (action.type) {
    case RECEIVE_USERS:
      const { users } = action;
      return Object.assign({}, oldState, users);
      // debugger
      // const users = action.users; // same as line above
      // const newUsers = {};
      // action.users.forEach(user => {
      //   newUsers[user.id] = user;
      // });
    case RECEIVE_USER:
      const { user } = action;
      // Object.assign => merges objects together.
      // Object.assign({ 1: {name: 'ada'} }, { 1: {id: 1} })
      // will return => { 1: {id: 1}}
      // lodash merge => deep dupes the merging objects.
      // merge({ 1: {name: 'ada'} }, { 1: {id: 1} })
      // will return => { 1: {name: 'ada', id: 1} }
      return Object.assign({}, oldState, { [user.id]: user });
      // when we are setting a key to a variable 
      // (we want it to be the value of that variable) => we need to 
      // interpolate it in brackets. 
      // {[user.id]: user} => { 1: {id: 1, name: 'Ada'} }
    default:
      return state;
  }
};