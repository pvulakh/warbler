import React from 'react';
import { connect } from 'react-redux';
import { fetchUser } from '../../actions/user_actions';

class UserShow extends React.Component {
    componentDidMount() {
        const { warblerId, fetchWarbler } = this.props;
        fetchWarbler(warblerId);
    }

    componentDidUpdate(prevProps) {
        const { warblerId, fetchWarbler } = this.props;
        if (warblerId != prevProps.warblerId) {
            fetchWarbler(warblerId);
        }
    }

    render() {
        const { warbler = {}, closeShow, warbleCount, location = {} } = this.props;
        // ^ if this.props.warbler is undefined - make it an empty object.
        // because if we call warbler.name => undefined.name - that would break.
        // so we set it to {} so that {}.name returns undefined and does not break.

        return (
            <aside className="user-show">
                <h2>{warbler.name}</h2>
                <h3>{location.name}</h3>
                <p><strong>Warble count:</strong>{warbleCount}</p>
                <button onClick={closeShow}>Close</button>
            </aside>
        );
    }
}

const msp = (state, ownProps) => {
    const warbler = state.entities.users[ownProps.warblerId];
    const location = state.entities.locations[warbler.location_id];
    const warbleCount = Object.values(state.entities.warbles).filter(warble => warble.author_id == ownProps.warblerId).length
    return {
        warbler,
        warbleCount,
        location,
    };
};

const mdp = dispatch => {
    return {
        fetchWarbler: id => dispatch(fetchUser(id)),
    };
};

export default connect(msp, mdp)(UserShow)