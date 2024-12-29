class_name ErrorMessageTest extends GutTest

func test_basic() -> void:
	var err := ErrorMessage.new(ERR_BUG, "Hello world!")
	assert_eq(err.code, ERR_BUG)
	assert_eq(err.message, "Hello world!")
	assert_string_contains(err.to_string(), "Hello world!")
