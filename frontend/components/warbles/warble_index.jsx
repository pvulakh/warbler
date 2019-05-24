import React from 'react';
import { connect } from 'react-redux';
import WarbleIndexItem from './warble_index_item';
import { fetchWarbles } from '../../actions/warble_actions';

class WarbleIndex extends React.Component {
  constructor(props) {
    super(props);
    // debugger;
  }

  componentDidMount() {
    const { getWarbles } = this.props;
    // debugger;
    getWarbles();
  }

  render() {
    const { warbles } = this.props;
    const warbleItems = warbles.map(warble => <WarbleIndexItem key={warble.id} warble={warble} />);
    // debugger;
    return (
      <div className="warble-index">
        <h3>See what people are warbling!</h3>
        <ul>
          {warbleItems}
        </ul>
      </div>
    );
  }
}

const msp = (state) => {
  const { warbles } = state.entities;
  // debugger;
  return {
    warbles: Object.values(warbles),
  };
};

const mdp = (dispatch) => {
  // debugger;
  return {
    getWarbles: () => dispatch(fetchWarbles())
  }
}

export default connect(msp,mdp)(WarbleIndex);