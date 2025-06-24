const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    // Supposedly, this makes debugging in VSCode easier.
    const name = b.option([]const u8, "maton", "A little balloon game made with Raylib and Zig.");

    const root_module = b.createModule(.{
        .root_source_file = b.path("src/main.zig"),
        .target = target,
        .optimize = optimize,
    });

    // Grab dependencies here.
    const raylib_dep = b.dependency("raylib_zig", .{
        .target = target,
        .optimize = optimize,
    });

    // Import dependencies into scope.
    root_module.addImport("raylib", raylib_dep.module("raylib"));

    // Link dependencies to root module. May be more useful when
    // linking our own version of Raylib.
    root_module.linkLibrary(raylib_dep.artifact("raylib"));

    // Compile the executable.
    {
        const exe = b.addExecutable(.{ .name = name orelse "maton", .root_module = root_module });
        b.installArtifact(exe);

        // Run after install.

        const run_cmd = b.addRunArtifact(exe);
        run_cmd.step.dependOn(b.getInstallStep());

        if (b.args) |args| run_cmd.addArgs(args);

        const run_step = b.step("run", "Run the game.");
        run_step.dependOn(&run_cmd.step);

    }
}
