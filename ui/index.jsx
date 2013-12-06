var React = require('react');
var ReactApp = require('react-app');

var Main = React.createClass({
  fetchData: function(req, cb) {
    // do XHR call here
    console.log('fetching data...');
    cb(null, {msg: 'Hello!'});
  },
  render: function() {
    var data = this.props.request.data;
    return (
      <div className="Main">
        <p>{data ? data.msg : 'Loading...'}</p>
        <a href="/about">About</a>
      </div>
    )
  }
});

var About = React.createClass({
  render: function() {
    return (
      <div className="About">
        About
        <a href="/">index</a>
      </div>
    )
  }
});

module.exports = ReactApp({
  routes: {
    '/': Main,
    '/about': About
  },

  onClick: function(e) {
    if (e.target.tagName === 'A' && e.target.attributes.href) {
      e.preventDefault();
      this.navigate(e.target.attributes.href.value);
    }
  },

  componentDidMount: function() {
    window.addEventListener('click', this.onClick);
  },

  componentWillUnmount: function() {
    window.removeEventListener('click', this.onClick);
  }
});
