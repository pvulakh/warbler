import React from 'react';
import { Provider } from 'react-redux';
import WarbleIndex from './warbles/warble_index';
import NewWarbleForm from './warbles/new_warble_form_container';
import UserIndex from './users/user_index';
import { HashRouter, Route, Switch } from 'react-router-dom';
import WarbleShow from './warbles/warble_show';
// Switch renders the component (and its children) from the first path that matches the current path
// For rendering multiple NON-nested components, don't use switch
export default ({ store }) => (
  <Provider store={store}> 
    <HashRouter>
      <div className="app-content">
      <img className="img-warbler" src={window.warblerURL} />
        <Switch >
          <Route path='/users' component={UserIndex} /> 
          <Route path='/new_warble' component={NewWarbleForm} />
          <Route path='/warbles/:warbleId' component={WarbleShow} />
          {/* we keep :warbleId as a true string because the Route component
            takes care of interpolating the actual :warbleId value for us */}
          <Route path='/' component={WarbleIndex} />
        </Switch>
      </div>
    </HashRouter>
  </Provider>
);

