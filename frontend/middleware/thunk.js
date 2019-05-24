// what is a thunk? a function that wraps an expression to delay its evaluation
// our middleware will intercept all dispatched actions to check where they need to go, db, reducers, etc
// sounds like currying

const thunk = ({ dispatch, getState }) => {
  // debugger;
  return next => {
    // debugger;
    return action => {
      // debugger;
      if (typeof action === 'function') {
        // debugger;
        return action(dispatch, getState);
      } else {
        // debugger;
        // next could be another piece of middleware or the rootReducer
        return next(action);
      }
    };
  };
};

export default thunk;