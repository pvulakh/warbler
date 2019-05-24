import * as WarbleAPIUtil from '../util/warble_api_util';
export const RECEIVE_WARBLE = 'RECEIVE_WARBLE';
export const REMOVE_WARBLE = 'REMOVE_WARBLE';
export const RECEIVE_WARBLES = 'RECEIVE_WARBLES';

export const receiveWarbles = (warbles) => {
  // debugger;
  return {
    type: RECEIVE_WARBLES,
    warbles,
  };
};

// how to know if you need to use a sync (regular) or thunk (async) action creator?
//-  need thunk (async) when we want to interact with our database (get, post, patch, etc.)
//- we need a regular action creator in order to receive info coming from the database 
// in order to integrate it into the redux store

// *there WILL be things we'll want to do strictly on the frontend for our apps
// that will NOT require interacting with the database

export const receiveWarble = (warble) => { // regular action creator since returns a pojo with a type property
  // debugger
  return {
    type: RECEIVE_WARBLE,
    warble,
  };
};

export const removeWarble = id => {
  return {
    type: REMOVE_WARBLE,
    id,
  };
};

export const fetchWarbles = () => {
  // debugger;
  return (dispatch) => {
    // debugger;
    return WarbleAPIUtil.fetchWarbles().then(warbles => {
      // debugger;
      return dispatch(receiveWarbles(warbles));
    });
  };
};

export const fetchWarble = id => {
  // debugger
  return dispatch => {
    // debugger
    return WarbleAPIUtil.fetchWarble(id).then(warble => {
      // debugger
      return dispatch(receiveWarble(warble));
    });
  };
};

export const createWarble = warble => {
  // debugger
  return (dispatch) => {
    // debugger
    return WarbleAPIUtil.createWarble(warble).then(warble => {
      // debugger
      return dispatch(receiveWarble(warble));
    });
  };
};