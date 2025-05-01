package thirdparty

//go:generate mkdir -p github.com/envoyproxy/protoc-gen-validate/validate
//go:generate curl -fsSL https://github.com/envoyproxy/protoc-gen-validate/raw/main/validate/validate.proto -o github.com/envoyproxy/protoc-gen-validate/validate/validate.proto

//go:generate mkdir -p github.com/pseudomuto/protokit/fixtures
//go:generate curl -fsSL https://github.com/pseudomuto/protokit/raw/master/fixtures/extend.proto -o github.com/pseudomuto/protokit/fixtures/extend.proto
