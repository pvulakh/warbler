import React from 'react';
import { withRouter, Link } from 'react-router-dom'; 
import { connect } from 'react-redux';
import { fetchWarble } from '../../actions/warble_actions';

class WarbleShow extends React.Component { // this is the presentational component - this file contains the container as well 
  constructor(props) {
    super(props);
    // debugger
  }

  componentDidMount() {
    // debugger
    this.props.fetchWarble(this.props.match.params.warbleId);
  }

  componentDidUpdate(prevProps) { // used to fetch new info that's not already in our store when something about our comp has changed
    // debugger
    if (this.props.match.params.warbleId !== prevProps.match.params.warbleId) {
      this.props.fetchWarble(this.props.match.params.warbleId);
    }
  }

  render() {
    // debugger
    return (
      <>
        <p>{this.props.warble.body}</p>
        <Link to='/'>Back to Index</Link>
      </>
    );
  }
}

//msp augments props, doesn't replace inline ones!
const mapStateToProps = (state, ownProps) => { // ownProps are in-line props of this component (does not need to be called ownProps) - is passed in to presentational comp automatically 
  // debugger
  const warbleId = ownProps.match.params.warbleId; // get the wildcard from our path
  const warble = state.entities.warbles[warbleId] || {}; // if our warble isn't in state yet, set it to {} to avoid errors (will fetch warble later!)
  return { 
    warble
  };
};

const mapDispatchToProps = dispatch => {
  return {
    fetchWarble: id => dispatch(fetchWarble(id))
  };
};

export default withRouter(connect(mapStateToProps, mapDispatchToProps)(WarbleShow)); // this is the connected, routed component itself
// withRouter provides our component access to the HashRouter 
// - this gives us access to the `match` key on line 21, which lets us see wildcards