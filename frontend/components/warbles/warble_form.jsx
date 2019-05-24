import React from 'react';

class WarbleForm extends React.Component {
  constructor(props) {
    super(props);
    const { body } = props;
    this.state = {
      body,
    };
    this.handleSubmit = this.handleSubmit.bind(this);
  }

  handleChange(field) {
    return (e) => {
      this.setState({ [field]: e.target.value });
    };
  }

  handleSubmit(e) {
    e.preventDefault();
    const { warbleAction } = this.props;
    // debugger
    const warble = this.state;
    warble.id = Math.floor(Math.random() * 10000);
    warbleAction(warble);
    this.setState({ body: '' });
  }

  render() {
    const { body } = this.state;
    const { inputLabel } = this.props;
    return (
      <form onSubmit={this.handleSubmit} className="warble-form">
        <label htmlFor="warble-body">{inputLabel}:
          <input
            id="warble-body"
            type="text"
            onChange={this.handleChange('body')}
            value={body}
          />
        </label>
        <br />
        <input type="submit" className="warble-button" value="Warble it!" />
      </form>
    );
  }
}

export default WarbleForm;