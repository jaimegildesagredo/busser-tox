Feature: Test command
  In order to run tests with different python versions
  As a user of Busser
  I want my tests to run when the tox runner plugin is installed

  Background:
    Given a test BUSSER_ROOT directory named "busser-tox-test"
    When I successfully run `busser plugin install busser-tox --force-postinstall`
    Given a suite directory named "tox"

  Scenario: A passing test suite
    Given a file in suite "tox" named "tox.ini" with:
    """
    [tox]
    envlist = py27

    [testenv]
    sitepackages = True
    deps = mamba
    commands = mamba
    """
    And a file in suite "tox" named "setup.py" with:
    """
    # -*- coding: utf-8 -*-

    from distutils.core import setup

    setup(
        name='busser-tox-example',
        version='0.1.0'
    )
    """
    When I run `busser test tox`
    Then the output should contain:
    """
    0 examples ran
    """
    And the exit status should be 0

  Scenario: A failing test suite
    Given a file in suite "tox" named "tox.ini" with:
    """
    [tox]
    envlist = py27
    """
    When I run `busser test tox`
    Then the output should contain:
    """
    tox.MissingFile:
    """
    And the exit status should not be 0
