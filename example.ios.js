/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 */
'use strict';

var React = require('react-native');
var { NativeModules } = React;
var { RNPlayAudio } = NativeModules;

var {
  AppRegistry,
  StyleSheet,
  Text,
  TouchableHighlight,
  View,
} = React;

var testComp = React.createClass({
  componentDidMount() {
    // no actions in mount
  },
  startAudio: function() {
    console.log('in start play');
    RNPlayAudio.startAudio(
        "test.caf", // fileName
        function errorCallback(results) {
            console.log('JS Error: ' + results['errMsg']);
        },
        function successCallback(results) {
            console.log('JS Success: ' + results['successMsg']);
        }
    );
  },
  stopAudio: function() {
    console.log("in stop play");
    RNPlayAudio.stopAudio(
        "test.caf", // fileName
        function errorCallback(results) {
            console.log('JS Error: ' + results['errMsg']);
        },
        function successCallback(results) {
            console.log('JS Success: ' + results['successMsg']);
        }
    );
  },
  pauseAudio: function() {
    console.log("in pause play");
    RNPlayAudio.pauseAudio(
        "test.caf", // fileName
        function errorCallback(results) {
            console.log('JS Error: ' + results['errMsg']);
        },
        function successCallback(results) {
            console.log('JS Success: ' + results['successMsg']);
        }
    );
  },
  render: function() {
    return (
      <View style={styles.container}>
        <Text style={styles.welcome}>
          Check Audio Status - View Xcode Log
        </Text>
        <TouchableHighlight onPress={this.startAudio}>
          <Text style={styles.instructions}>
            Press to Play
          </Text>
        </TouchableHighlight>
        <TouchableHighlight onPress={this.pauseAudio}>
          <Text style={styles.instructions}>
            Press to Pause
          </Text>
        </TouchableHighlight>
        <TouchableHighlight onPress={this.stopAudio}>
          <Text style={styles.instructions}>
            Press to Stop
          </Text>
        </TouchableHighlight>
      </View>
    );
  }
});

var styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#F5FCFF',
  },
  welcome: {
    fontSize: 20,
    textAlign: 'center',
    margin: 10,
  },
  instructions: {
    textAlign: 'center',
    color: '#333333',
    marginBottom: 5,
  },
});

AppRegistry.registerComponent('testComp', () => testComp);
