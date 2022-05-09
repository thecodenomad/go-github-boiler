package main

import (
	"github.com/stretchr/testify/require"
	"github.com/stretchr/testify/suite"
	"testing"
)

type MainTestSuite struct {
	suite.Suite
	*require.Assertions
}

func (suite *MainTestSuite) SetupTest() {
	suite.Assertions = suite.Suite.Require()
}

// Do the suite thing
func TestMainSuite(t *testing.T) {
	suite.Run(t, new(MainTestSuite))
}

// Suite tests go here
func (suite *MainTestSuite) TestSomething() {
	suite.True(bogusFunc() == 1)
}
