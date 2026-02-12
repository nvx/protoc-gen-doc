package gendoc

import (
	"github.com/pseudomuto/protokit/utils"
	"testing"
)

func BenchmarkParseCodeRequest(b *testing.B) {
	set, _ := utils.LoadDescriptorSet("fixtures", "fileset.pb")
	req := utils.CreateGenRequest(set, "Booking.proto", "Vehicle.proto")
	plugin := new(Plugin)

	for b.Loop() {
		plugin.Generate(req)
	}
}
