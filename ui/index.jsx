var React = require('react-tools/build/modules/React');
var ReactApp = require('react-app');

var Main = React.createClass({
  render: function() {
    return (
      <div className="Main">
        Hello!
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

var app = module.exports = ReactApp({
  '/': Main,
  '/about': About
}, {
  started: function() {
    window.addEventListener('click', function(e) {
      if (e.target.tagName === 'A' && e.target.attributes.href) {
        e.preventDefault();
        app.navigate(e.target.attributes.href.value);
      }
    });
  }
})
