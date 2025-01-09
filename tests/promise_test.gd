class_name PromiseTest extends GutTest

func test_promise_callable() -> void:
	var work := func(resolve: Callable, _reject: Callable) -> void:
		await (Engine.get_main_loop() as SceneTree).process_frame
		await (Engine.get_main_loop() as SceneTree).process_frame
		resolve.call()
	
	var prom := Promise.new(work)
	watch_signals(prom)
	assert_signal_not_emitted(prom, "done")
	assert_signal_not_emitted(prom, "fulfilled")
	await get_tree().process_frame
	assert_signal_not_emitted(prom, "done")
	assert_signal_not_emitted(prom, "fulfilled")
	await get_tree().process_frame
	await get_tree().process_frame
	assert_signal_emitted(prom, "done")
	assert_signal_emitted(prom, "fulfilled")

func test_promise_chaining() -> void:
	var work := func(resolve: Callable, _reject: Callable) -> void:
		await (Engine.get_main_loop() as SceneTree).process_frame
		await (Engine.get_main_loop() as SceneTree).process_frame
		resolve.call()
	
	var work2 := func() -> void:
		await (Engine.get_main_loop() as SceneTree).process_frame
		await (Engine.get_main_loop() as SceneTree).process_frame
	
	var prom1 := Promise.new(work)
	var prom2 := prom1.then(work2)
	watch_signals(prom1)
	watch_signals(prom2)
	assert_signal_not_emitted(prom1, "done")
	assert_signal_not_emitted(prom1, "fulfilled")
	assert_signal_not_emitted(prom2, "done")
	assert_signal_not_emitted(prom2, "fulfilled")
	await get_tree().process_frame
	assert_signal_not_emitted(prom1, "done")
	assert_signal_not_emitted(prom1, "fulfilled")
	assert_signal_not_emitted(prom2, "done")
	assert_signal_not_emitted(prom2, "fulfilled")
	await get_tree().process_frame
	await get_tree().process_frame
	assert_signal_emitted(prom1, "done")
	assert_signal_emitted(prom1, "fulfilled")
	assert_signal_not_emitted(prom2, "done")
	assert_signal_not_emitted(prom2, "fulfilled")
	await get_tree().process_frame
	await get_tree().process_frame
	assert_signal_emitted(prom1, "done")
	assert_signal_emitted(prom1, "fulfilled")
	assert_signal_emitted(prom2, "done")
	assert_signal_emitted(prom2, "fulfilled")
