test_expect_success 'setup' '
	cat >path0 <<-\EOF &&
	Line 1
	Line 2
	Line 3
	Line 4
	Line 5
	Line 6
	Line 7
	Line 8
	Line 9
	Line 10
	line 11
	Line 12
	Line 13
	Line 14
	Line 15
	EOF
	cat >expected <<-\EOF &&
	diff --git a/path0 b/path1
	rename from path0
	rename to path1
	--- a/path0
	+++ b/path1
	@@ -8,7 +8,7 @@ Line 7
	 Line 8
	 Line 9
	 Line 10
	-line 11
	+Line 11
	 Line 12
	 Line 13
	 Line 14
	EOF
	cat >no-rename <<-\EOF
	diff --git a/path0 b/path0
	deleted file mode 100644
	index fdbec44..0000000
	--- a/path0
	+++ /dev/null
	@@ -1,15 +0,0 @@
	-Line 1
	-Line 2
	-Line 3
	-Line 4
	-Line 5
	-Line 6
	-Line 7
	-Line 8
	-Line 9
	-Line 10
	-line 11
	-Line 12
	-Line 13
	-Line 14
	-Line 15
	diff --git a/path1 b/path1
	new file mode 100644
	index 0000000..752c50e
	--- /dev/null
	+++ b/path1
	@@ -0,0 +1,15 @@
	+Line 1
	+Line 2
	+Line 3
	+Line 4
	+Line 5
	+Line 6
	+Line 7
	+Line 8
	+Line 9
	+Line 10
	+Line 11
	+Line 12
	+Line 13
	+Line 14
	+Line 15
	EOF

test_expect_success 'test diff.renames=true' '
	git -c diff.renames=true diff --cached $tree >current &&
	compare_diff_patch current expected
'

test_expect_success 'test diff.renames=false' '
	git -c diff.renames=false diff --cached $tree >current &&
	compare_diff_patch current no-rename
'

test_expect_success 'test diff.renames unset' '
	git diff --cached $tree >current &&
	compare_diff_patch current expected
'
