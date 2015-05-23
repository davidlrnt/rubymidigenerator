require 'unimidi'
require 'pry'

notes = {:c => 0, :csharp => 1,:d => 2, :dsharp => 3,:e => 4, :f => 5, :fsharp=> 6, :g => 7, :gsharp => 8, :a => 9, :asharp => 10, :b => 11}

# notes = [24, 27, 29, 31, 34, 36, 39, 41, 43, 46, 48, 51, 53, 55, 58, 60, 63, 65, 67, 70, 72, 75, 77, 79, 82, 84, 87, 89, 91, 94, 96, 99, 101, 103, 106] #C minor pentatonic
# duration = 0.3

#scales
c_major = [notes[:c],notes[:d],notes[:e],notes[:f],notes[:g],notes[:a],notes[:b]]
half_step = 1
whole_step = 2

puts "Type a note"
n = notes[gets.chomp.to_sym]
puts "What octave?"
octave = gets.chomp.to_i
note = n + (octave * 12)
puts "BPM?"
tempo = gets.chomp.to_f


def generate_tempo_arr(tempo)
    tempoarr = []
    tempoarr << 60/tempo
    tempoarr << tempoarr[-1]/2
    tempoarr << tempoarr[-1]/2
    tempoarr
end

tempoarr = generate_tempo_arr(tempo)
# binding.pry
# puts tempoarr

def major(note)
    major = [0, 2, 4, 5, 7, 9, 11, 12]
    major.map do |value|
       note + value
    end
end

def natural_minor(note)
    natural_minor = [0,2,3,5,7,8,10,12]
    natural_minor.map do |value|
        note + value
    end
end

def harmonic_minor(note)
    harmonic_minor = [0,2,3,5,7,8,11,12]
    harmonic_minor.map do |value|
        note + value
    end
end

def major_arpeggio(note)
     arpeggio_major = [0, 4, 7]
     arpeggio_major.map do |arpeggio|
        note + arpeggio
    end
end

def minor_arpeggio(note)
    arpeggio_minor = [0,3,7]
        arpeggio_minor.map do |value|
        note + value
    end
end

def dorian_mode(note)
    dorian_mode = [2,4,5,7,9,11,12,14]
    dorian_mode.map do |value|
        note + value
    end
end

def phrygian_dominant(note)
    dorian_mode = [3,4,7,8,10,11,13,15]
    dorian_mode.map do |value|
        note + value
    end
end

def

def modulate(note, notet)

end

output = UniMIDI::Output.gets

# output = UniMIDI::Output.open(:first)

output.open do |output|

    # major(note).each do |n|
    #     output.puts(0x90, n, 100)
    #     sleep(0.5)
    #     output.puts(0x80, n, 100)
    # end

    notesarray = major(note)
    # notesarray += harmonic_minor(note)
    20.times do
        note = notesarray.sample
        output.puts(0x90, note, 100)
        # sleep(rand(3)/10.to_f)
        sleep(tempoarr.sample)
        output.puts(0x80, note, 100)

    end

    notesarray = natural_minor(note)
    # notesarray += harmonic_minor(note)
    20.times do
        note = notesarray.sample
        output.puts(0x90, note, 100)
        # sleep(rand(3)/10.to_f)
        sleep(tempoarr.sample)

        output.puts(0x80, note, 100)

    end

    notesarray = harmonic_minor(note)

    20.times do
        note = notesarray.sample

        output.puts(0x90, note, 100)
        output.puts(0x90, note+4, 100)
        output.puts(0x90, note+7, 100)

        # sleep(tempo)
        sleep(tempoarr.sample)

        output.puts(0x80, note, 100)
        output.puts(0x80, note+4, 100)
        output.puts(0x80, note+7, 100)
    end

    a = 0
    v = 10
    r = 10
    t = 10
    x = 10
    note = notesarray.sample
    while a < 1000 do

        sleep(0.1)

        output.puts(0x90, note, v)
        # sleep(0.1)
        output.puts(0x80, note, v)

        if a > 300
        output.puts(0x90, note+4, r)
        # sleep(0.1)
        output.puts(0x80, note+4, r)
        r += 0.1
        end

        if a > 400
        output.puts(0x90, note+19, t)
        # sleep(0.1)
        output.puts(0x80, note+19, t)
        t += 0.1
        end


        if a > 200
        output.puts(0x90, note-19, x)
        # sleep(0.1)
        output.puts(0x80, note-19, x)
        x += 0.1
        end

    a += 1
    v += 0.1
    end


# binding.pry
  # 500.times do
  #   note = notes.sample
  #   output.puts(0x90, note, 100)
  #   # output.puts(0x90, note+5, rand(100))
  #   # output.puts(0x90, note+7, rand(100))

  #   sleep(rand(3)/10.to_f)

  #   output.puts(0x80, note, 100)
  #   # output.puts(0x80, note+5, 0)
  #   # output.puts(0x80, note+7, 0)

  # end

end
